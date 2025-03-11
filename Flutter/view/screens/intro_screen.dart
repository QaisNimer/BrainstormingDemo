import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/intro2_screen.dart';
import 'package:foodtek/view/screens/intro3_screen.dart';
import 'package:foodtek/view/screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:foodtek/view/screens/intro_screen.dart';
//import 'package:foodtek/view/screens/home_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/Order_food.png", height: 300),
                  SizedBox(height: 20),
                  Text(
                    "Welcome To Salah ",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    " Enjoy A Fast And Smooth Food Delivery At Your Doorstep",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),

                  ),

              SizedBox(height: 70),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Intro2Screen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
                ],
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),

                // **النقاط التقدمية**
                SmoothPageIndicator(
                  controller: _controller,
                  count: 1,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.green,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),

                // **زر السهم**
                IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.green, size: 28),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Intro2Screen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
