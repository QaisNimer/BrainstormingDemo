import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'login_screen.dart';

class CongraScreen extends StatefulWidget {
  const CongraScreen({super.key});

  @override
  State<CongraScreen> createState() => _CongraScreenState();
}

class _CongraScreenState extends State<CongraScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg_of_congra.png",
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(0.2)),
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/Congra.png",
                  width: 450,
                  height: 450,
                ),

                Text(
                  AppLocalizations.of(context)!.congratulations,
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                Text(
                  AppLocalizations.of(context)!.password_reset_successfully,
                  style: TextStyle(fontSize: 20, color: Colors.white70),
                ),

                SizedBox(height: 30),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.green,
                //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                //   ),
                //   child: Text(
                //     "Back to Login",
                //     style: TextStyle(fontSize: 16, color: Colors.white),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
