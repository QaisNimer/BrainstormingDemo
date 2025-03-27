import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // تأكد من إضافة هذه الحزمة إلى pubspec.yaml
import 'package:foodtek/view/screens/delete_cart_screen.dart';

import 'favorites_screen.dart';
import 'filter_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int selectedIndex2 = 0;
  int quantity = 3;
  double spiciness = 0.0;

  void onItemTapped2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.location_on, color: Colors.green, size: 31),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Current location", style: TextStyle(fontSize: 15)),
                Text(
                  "Jl. Soekarno Hatta 15A..",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_drop_down)),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 31,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Search menu, restaurant or etc",
                prefixIcon:  Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterScreen()));
                  },
                  icon:  Icon(Icons.tune),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
             SizedBox(height: 15),
            Container(child: Image.asset("assets/images/big_burger.png")),
             SizedBox(height: 17),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cheeseburger Wendy's Burger",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
             SizedBox(height: 6),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: 4.5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 25,
                  itemBuilder:
                      (context, _) => Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Text(
                  "4.5   (89 reviews)",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),

            SizedBox(height: 7),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$7.99",
                  style: TextStyle(fontSize: 26, color: Colors.green),
                ),
                SizedBox(width: 10),
                Stack(
                  children: [
                    Text(
                      "\$9.5",
                      style: TextStyle(fontSize: 21, color: Colors.green),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 14,
                      child: Container(height: 2, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Column(
              children: [
                Text(
                  "Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 14),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Spicy", style: TextStyle(color: Colors.grey)),
                    Text("Quantity", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Slider(
                            value: spiciness,
                            min: 0,
                            max: 10,
                            activeColor: Colors.red,
                            onChanged: (value) {
                              setState(() {
                                spiciness = value;
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Mild", style: TextStyle(color: Colors.green)),
                              Text("Hot", style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 80),
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.remove, size: 18, color: Colors.green),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          quantity.toString(),
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add, size: 18, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 13),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeleteCartScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,

                  padding: EdgeInsets.symmetric(horizontal: 110, vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Add To Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: selectedIndex2 == 0 ? Colors.green : Colors.grey,
              ),
              onPressed: () => {

                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen())),

                onItemTapped2(0)},
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: selectedIndex2 == 1 ? Colors.green : Colors.grey,
              ),
              onPressed: () => {

                Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoritesScreen())),

                onItemTapped2(1)},
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(
                Icons.history,
                color: selectedIndex2 == 3 ? Colors.green : Colors.grey,
              ),
              onPressed: () => onItemTapped2(3),
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: selectedIndex2 == 4 ? Colors.green : Colors.grey,
              ),
              onPressed: () => onItemTapped2(4),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(

        backgroundColor: Colors.green,
        onPressed: () {
          onItemTapped2(2);
        },
        child: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}