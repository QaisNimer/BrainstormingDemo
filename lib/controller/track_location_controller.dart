import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle, ByteData, rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class TrackLocationController with ChangeNotifier {
  // Coordinates
  LatLng restaurantPosition = const LatLng(31.964855679741643, 35.91818988224449);
  LatLng housePosition = const LatLng(31.957670515347687, 35.92963048108733);
  late LatLng carPosition; // Will be set to midpoint

  // Map items
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  BitmapDescriptor? restaurantIcon;
  BitmapDescriptor? carIcon;
  BitmapDescriptor? houseIcon;

  bool isInitialized = false;

  /// Initialize everything
   initializeMap() async {
    await _loadCustomIcons();
    carPosition = _midPoint; // Start in middle
    _updateMarkersAndRoute();
    isInitialized = true;
    notifyListeners();
  }

  /// Midpoint between restaurant and house
  LatLng get _midPoint => LatLng(
    (restaurantPosition.latitude + housePosition.latitude) / 2,
    (restaurantPosition.longitude + housePosition.longitude) / 2,
  );

  /// Load icons with resizing
 _loadCustomIcons() async {
    restaurantIcon = await _getResizedIcon('assets/images/resturant_icon.png', 100);
    carIcon = await _getResizedIcon('assets/images/car_icon.png', 100);
    houseIcon = await _getResizedIcon('assets/images/house_icon.png', 100);
  }

  /// Resize asset image to larger size
  _getResizedIcon(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    final frame = await codec.getNextFrame();
    final resized = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(resized!.buffer.asUint8List());
  }


  void _updateMarkersAndRoute() {
    markers = {
      Marker(
        markerId: const MarkerId('restaurant'),
        position: restaurantPosition,
        icon: restaurantIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
      Marker(
        markerId: const MarkerId('car'),
        position: carPosition,
        icon: carIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
      Marker(
        markerId: const MarkerId('house'),
        position: housePosition,
        icon: houseIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };

    polylines = {
      Polyline(
        polylineId: const PolylineId('route'),
        points: [restaurantPosition, housePosition],
        color: Colors.green,
        width: 4,
      ),
    };
  }

  /// Update car during animation
  void updateCarPosition(LatLng newPosition) {
    carPosition = newPosition;
    _updateMarkersAndRoute();
    notifyListeners();
  }

  /// Animate car from restaurant to house
  Future<void> simulateCarMovement() async {
    const steps = 100;
    final latStep = (housePosition.latitude - restaurantPosition.latitude) / steps;
    final lngStep = (housePosition.longitude - restaurantPosition.longitude) / steps;

    for (int i = 0; i <= steps; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      updateCarPosition(LatLng(
        restaurantPosition.latitude + (latStep * i),
        restaurantPosition.longitude + (lngStep * i),
      ));
    }
  }
}
