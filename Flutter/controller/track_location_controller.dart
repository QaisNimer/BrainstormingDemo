import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackLocationController with ChangeNotifier {
  LatLng restaurantPosition = const LatLng(31.963158, 35.930359);
  LatLng housePosition = const LatLng(31.965000, 35.932000);
  LatLng carPosition = const LatLng(31.963158, 35.930359);

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  BitmapDescriptor? restaurantIcon;
  BitmapDescriptor? carIcon;
  BitmapDescriptor? houseIcon;

  bool isInitialized = false;

  Future<void> initializeMap() async {
    await _loadCustomIcons();
    _updateMarkersAndRoute();
    isInitialized = true;
    notifyListeners();
  }

  Future<void> _loadCustomIcons() async {
    restaurantIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/restaurant_icon.png',
    );

    carIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/car_icon.png',
    );

    houseIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/house_icon.png',
    );
  }

  void _updateMarkersAndRoute() {
    markers = {
      Marker(
        markerId: const MarkerId('restaurant'),
        position: restaurantPosition,
        icon: restaurantIcon!,
        infoWindow: const InfoWindow(title: 'المطعم'),
      ),
      Marker(
        markerId: const MarkerId('car'),
        position: carPosition,
        icon: carIcon!,
        infoWindow: const InfoWindow(title: 'سيارة التوصيل'),
      ),
      Marker(
        markerId: const MarkerId('house'),
        position: housePosition,
        icon: houseIcon!,
        infoWindow: const InfoWindow(title: 'المنزل'),
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

  void updateCarPosition(LatLng newPosition) {
    carPosition = newPosition;
    _updateMarkersAndRoute();
    notifyListeners();
  }

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