import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/profile_screen.dart';

import '../widgets/food_cart2_widget.dart';
import 'client_location_screen.dart';
import 'delete_cart_screen.dart';
import 'history_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientLocationScreen()));
              },
              icon: Icon(Icons.location_on, color: Colors.green, size: 31),
            ),
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
        padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Search pizza, restaurant or etc",
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.tune),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Favorites",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: screenWidth / (screenWidth * 1.3),
                children: [
                  FoodCard2Widget(
                    title: "Pepperoni Pizza",
                    description: "Pepperoni pizza, Margarita Pizza, Italian cuisine",
                    price: "29.00",
                    imagePath: "assets/images/pizza (1).png",
                    rating: 4.5,
                    isRed: true,
                  ),
                  FoodCard2Widget(
                    title: "Pizza Cheese",
                    description: "Food pizza dish cuisine junk food, Fast Food",
                    price: "23.00",
                    imagePath: "assets/images/pizza1.png",
                    rating: 4.3,
                    isRed: true,
                  ),
                  FoodCard2Widget(
                    title: "Peppy Paneer",
                    description: "Chunky paneer with crisp capsicum & red pepper",
                    price: "13.00",
                    imagePath: "assets/images/pizza2.png",
                    rating: 4.2,
                    isRed: true,
                  ),
                  FoodCard2Widget(
                    title: "Mexican Green Wave",
                    description: "Crunchy onions, crisp capsicum, juicy tomatoes",
                    price: "23.00",
                    imagePath: "assets/images/pizza3.png",
                    rating: 4.7,
                    isRed: true,
                  ),
                ],
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
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.green,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoritesScreen()));

              },
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(
                Icons.history,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryScreen()));

              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.grey,
              ),
              onPressed:
                  () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                ),

              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteCartScreen()));

        },
        child: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}