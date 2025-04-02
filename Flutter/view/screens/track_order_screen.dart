import 'package:flutter/material.dart';
import 'package:untitled/view/screen/favourites_screen.dart';
import 'package:untitled/view/screen/history_screen.dart';
import 'package:untitled/view/screen/home_screen.dart';

class TrackOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Order Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset("assets/images/order_icon.png", width: 40, height: 40),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order ID", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("#6579-6432",style: TextStyle(color: Colors.grey)),
                    Text("25m", ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Order Status
            Column(
              children: [
                buildOrderStatus("Order received", true, Icons.check_circle),
                buildOrderStatus("Cooking your order", true, Icons.kitchen),
                buildOrderStatus("Courier is picking up order", true, Icons.person),
                buildOrderStatus("Order delivered", false, Icons.home),
              ],
            ),
            SizedBox(height: 20),

            // Delivery Hero
            // Delivery Hero
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/images/delivery_person.png"),
              ),
              title: Text("Aleksandr V."),
              subtitle: Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  SizedBox(width: 4),
                  Text("4.9"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Call Button
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: IconButton(
                      icon: Icon(Icons.call, color: Colors.green),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 10),
                  // Chat Button
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: IconButton(
                      icon: Icon(Icons.chat, color: Colors.orange),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.location_on, color: Colors.green),
              title: Text("123 Al-Madina Street, Abdali, Amman, Jordan"),
            ),

            SizedBox(height: 100),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text("Live Track", style: TextStyle(color: Colors.white, fontSize: 16)),
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
                color: Colors.green,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesScreen(),
                  ),
                );
              },
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(
                Icons.history,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildOrderStatus(String title, bool isCompleted, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(icon, color: isCompleted ? Colors.green : Colors.grey),
            if (title != "Order delivered")
              Container(width: 2, height: 30, color: isCompleted ? Colors.green : Colors.grey),
          ],
        ),
        SizedBox(width: 10),
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}