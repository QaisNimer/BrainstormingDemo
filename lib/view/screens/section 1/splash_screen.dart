import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/section%202/Congra_screen.dart';
import 'package:foodtek/view/screens/section%201/intro_screen.dart';
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
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/foodtek.png"),
          fit: BoxFit.cover,
        ),
      ),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage("assets/images/foodtek.png"),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //   ),
    //
    ),


    );

  }
}
