import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/intro3_screen.dart';
import 'package:foodtek/view/screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class Intro2Screen extends StatefulWidget {
  const Intro2Screen({super.key});

  @override
  State<Intro2Screen> createState() => _Intro2ScreenState();
}

class _Intro2ScreenState extends State<Intro2Screen> {
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
                  Image.asset("assets/images/Delivery.png", height: 300),
                  SizedBox(height: 20),
                  Text(
                    "Get Delivery On Time",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Order Your Favorite Food Within The Palm Of Your Hand And The Zone Of Your Comfort",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 70),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Intro3Screen()),
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
                  count: 2,
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
                      MaterialPageRoute(builder: (context) => Intro3Screen()),
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
