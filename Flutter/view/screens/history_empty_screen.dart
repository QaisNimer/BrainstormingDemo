import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/history_screen.dart';


import 'cart_empty_screen.dart';
import 'delete_cart_screen.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';

class HistoryEmptyScreen extends StatefulWidget {
  const HistoryEmptyScreen({super.key});

  @override
  _HistoryEmptyScreenState createState() => _HistoryEmptyScreenState();
}

class _HistoryEmptyScreenState extends State<HistoryEmptyScreen> {
  int selectedIndex = 0;
  int selectedTabIndex = 1;
  bool isFavoriteSelected = false;

  void onTabTapped(int index) {
    setState(() {
      selectedTabIndex = index;
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
      backgroundColor: Colors.white,
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
              icon: Icon(Icons.notifications_none, color: Colors.black, size: 31),
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
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartEmptyScreen()),
                    );
                  },
                  child: Column(
                    children: [
                      Text("Cart",
                          style: TextStyle(
                              color: selectedTabIndex == 0 ? Colors.green : Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      if (selectedTabIndex == 0)
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          height: 2,
                          width: 150,
                          color: Colors.green,
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => onTabTapped(1),
                  child: Column(
                    children: [
                      Text("History",
                          style: TextStyle(
                              color: selectedTabIndex == 1 ? Colors.green : Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      if (selectedTabIndex == 1)
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          height: 2,
                          width: 100,
                          color: Colors.green,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/cart_empty.png',
                  height: 250,
                ),
                SizedBox(height: 20),
                Text(
                  'History Empty',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "You don’t have order any foods before.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
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
                color: selectedIndex == 0 ? Colors.green : Colors.grey,
              ),
              onPressed: () => {

                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen())),

                onItemTapped(0)},
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: isFavoriteSelected ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isFavoriteSelected = true;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()),
                ).then((_) {
                  setState(() {
                    isFavoriteSelected = false;
                  });
                });
              },
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(
                Icons.history,
                color: selectedIndex == 3 ? Colors.green : Colors.grey,
              ),
              onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryScreen())),

                onItemTapped(3)},
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: selectedIndex == 4 ? Colors.green : Colors.grey,
              ),
              onPressed: () => onItemTapped(4),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteCartScreen()));

          onItemTapped(2);
        },
        child: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}