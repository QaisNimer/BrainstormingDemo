import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/intro_screen.dart';
//import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 4),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => IntroScreen(),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Image.asset("assets/images/foodtek.png"),

    );
  }
}
