import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/delete_cart_screen.dart';
import 'package:foodtek/view/screens/profile_screen.dart';
import 'package:foodtek/view/widgets/history_widget.dart';

import 'client_location_screen.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedTab = 0;
  int selectedIndex = 0;

  void onTabChanged(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
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
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientLocationScreen(),
                  ),
                );
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed:
                        () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeleteCartScreen(),
                            ),
                          ),

                          onTabChanged(0),
                        },
                    child: Column(
                      children: [
                        Text(
                          "Cart",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                selectedTab == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                selectedTab == 1 ? Colors.green : Colors.black,
                          ),
                        ),
                        if (selectedTab == 1)
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: Colors.green,
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed:
                        () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoryScreen(),
                            ),
                          ),
                          onTabChanged(1),
                        },
                    child: Column(
                      children: [
                        Text(
                          "History",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                selectedTab == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                selectedTab == 0 ? Colors.green : Colors.black,
                          ),
                        ),
                        if (selectedTab == 0)
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: Colors.green,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  HistoryWidget(
                    title: "Chicken Burger",
                    subtitle: "Burger Factory LTD",
                    price: 20,
                    image: "assets/images/chicken.burger.png",
                    date: DateTime.now(),
                  ),
                  HistoryWidget(
                    title: "Onion Pizza",
                    subtitle: "Pizza Palace",
                    price: 15,
                    image: "assets/images/onion.pizza.png",
                    date: DateTime.now(),
                  ),
                  HistoryWidget(
                    title: "Spicy Shawarma",
                    subtitle: "Hot Cool Spot",
                    price: 15,
                    image: "assets/images/shawarma.png",
                    date: DateTime.now(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Load More..",
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: selectedIndex == 0 ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
                onItemTapped(0);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: selectedIndex == 1 ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoritesScreen(),
                  ),
                );
                onItemTapped(1);
              },
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: Icon(
                Icons.history,
                color: selectedIndex == 3 ? Colors.green : Colors.grey,
              ),
              onPressed:
                  () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryScreen()),
                    ),

                    onItemTapped(3),
                  },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: selectedIndex == 4 ? Colors.green : Colors.grey,
              ),
              onPressed:
                  () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    ),

                    onItemTapped(4),
                  },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DeleteCartScreen()),
          );

          onItemTapped(2);
        },
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
