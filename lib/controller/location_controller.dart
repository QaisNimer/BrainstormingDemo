import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends ChangeNotifier {
  LatLng? _userLocation;
  String _address = "Fetching location...";

  LatLng? get userLocation => _userLocation;
  String get address => _address;

  void setLocation(LatLng location, String address) {
    _userLocation = location;
    _address = address;
    notifyListeners();
  }
}
