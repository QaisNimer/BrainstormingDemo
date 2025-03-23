import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:foodtek/view/screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro4LocationScreen extends StatefulWidget {

  @override
  State<Intro4LocationScreen> createState() => _Intro4LocationScreenState();
}

class _Intro4LocationScreenState extends State<Intro4LocationScreen> {
  Future<void> _enableLocation(BuildContext context) async {


    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location services are disabled. Please enable them.")),
      );
      Geolocator.openLocationSettings();
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Location services are enabled.")),
    );

  }

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Delivery.png',
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text(
                  "Turn On Your Location",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "To continue, let your device turn on location, "
                      "which uses Google's Location Service",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
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
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    "Yes, Turn It On",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: Size(double.infinity, 50),
                    side: BorderSide(color: Colors.grey[400]!),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

              ],
            ),
          ),
          const SizedBox(height: 50),


        ],
      ),
    );
  }
}