import 'package:flutter/material.dart';
import 'package:untitled/view/screen/favourites_screen.dart';
import 'package:untitled/view/screen/history_screen.dart';
import 'package:untitled/view/widgets/cart_item2_widget.dart'; // استيراد الوديجت الجديدة
import 'package:untitled/view/widgets/cart_total_widget.dart';
import 'home_screen.dart';
import 'notification_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => onTabChanged(0),
                    child: Column(
                      children: [
                        Text(
                          "Cart",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                            selectedTab == 0 ? FontWeight.bold : FontWeight.normal,
                            color: selectedTab == 0 ? Colors.green : Colors.black,
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
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen()));
                      onTabChanged(1);
                    },
                    child: Column(
                      children: [
                        Text(
                          "History",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                            selectedTab == 1 ? FontWeight.bold : FontWeight.normal,
                            color: selectedTab == 1 ? Colors.green : Colors.black,
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
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  CartItem2Widget(
                    title: "Chicken Burger",
                    subtitle: "Burger Factory LTD",
                    price: 20,
                    image: "assets/images/chicken_burger.png",
                  ),
                  CartItem2Widget(
                    title: "Onion Pizza",
                    subtitle: "Pizza Palace",
                    price: 15,
                    image: "assets/images/onion_pizza.png",
                  ),
                  CartItem2Widget(
                    title: "Spicy Shawarma",
                    subtitle: "Hot Cool Spot",
                    price: 15,
                    image: "assets/images/shawarma.png",

                  ),
                  CartItem2Widget(
                    title: "Spicy Shawarma",
                    subtitle: "Hot Cool Spot",
                    price: 15,
                    image: "assets/images/shawarma.png",
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              CartTotalWidget(
                subtotal: 100,
                delivery: 10,
                discount: 10,
                onOrderPressed: () {},
              ),
            ],
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
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
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
                    builder: (context) => FavoritesScreen(),
                  ),
                );
                onItemTapped(1);
              },
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(
                Icons.history,
                color: selectedIndex == 3 ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen()));
                onItemTapped(3);
              },
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
          onItemTapped(2);
        },
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
