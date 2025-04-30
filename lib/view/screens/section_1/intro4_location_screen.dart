import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../controller/lang_controller.dart';
import '../section_2/login_screen.dart';
import '../section_3/home_screen.dart';

class Intro4LocationScreen extends StatefulWidget {
  const Intro4LocationScreen({super.key});

  @override
  State<Intro4LocationScreen> createState() => _Intro4LocationScreenState();
}

class _Intro4LocationScreenState extends State<Intro4LocationScreen> {
  Future<void> _enableLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "📍 Location services are disabled. Please enable them.",
          ),
        ),
      );
      await Geolocator.openLocationSettings();
      return;
    }

    PermissionStatus permission = await Permission.location.request();

    if (permission == PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Location permission granted!")),
      );

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      LatLng latLng = LatLng(position.latitude, position.longitude);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(userLocation: latLng),
        ),
      );
    } else if (permission == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Location permission denied.")),
      );
    } else if (permission == PermissionStatus.permanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "⚠️ Location permission permanently denied. Open settings to allow.",
          ),
        ),
      );
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/Delivery.png', fit: BoxFit.contain),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.turn_on_your_location,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text(
                  AppLocalizations.of(context)!
                      .to_continues_let_your_device_turn_on_location_which_uses_googles_location_service,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => _enableLocation(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.yes_turn_it_on,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                    side: BorderSide(
                      color: isDarkMode ? Colors.grey[600]! : Colors.grey[400]!,
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.btn_cancel,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}