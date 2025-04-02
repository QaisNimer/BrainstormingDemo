import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/check_out_done_screen.dart';
import 'package:foodtek/view/screens/delete_cart_screen.dart';
import 'package:foodtek/view/screens/history_screen.dart';
import 'package:foodtek/view/screens/home_screen.dart';
import 'package:foodtek/view/screens/profile_screen.dart';


import '../widgets/credit_card_widget.dart';
import 'notification_screen.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();

  int selectedIndex = 0;
  int selectedIndexNotification = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onNotificationTapped() {
    setState(() {
      selectedIndexNotification = (selectedIndexNotification == 0) ? 1 : 0;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Add Card", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
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
        elevation: 0,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CreditCardWidget(
              cardHolderName: _nameController.text,
              cardNumber: _cardNumberController.text,
              expiryDate: _expiryController.text,
            ),
            const SizedBox(height: 10),
            const Text("Name", style: TextStyle(fontSize: 14, color: Colors.grey)),
            TextField(
              controller: _nameController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: "your name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Card Number", style: TextStyle(fontSize: 14, color: Colors.grey)),
            TextField(
              controller: _cardNumberController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: "1234 1234 1234 1234",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                suffixIcon: const Icon(Icons.credit_card),
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Expiry", style: TextStyle(fontSize: 14, color: Colors.grey)),
                      TextField(
                        controller: _expiryController,
                        onChanged: (value) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: "MM/YY",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        ),
                        keyboardType: TextInputType.datetime,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("CVC", style: TextStyle(fontSize: 14, color: Colors.grey)),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "123",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "We will send you an order details to your email after the successful payment",
              style: TextStyle(color: Colors.black54, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOutDoneScreen()));

                },
                icon: const Icon(Icons.lock, color: Colors.white),
                label: const Text("Pay for the order", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: selectedIndex == 0 ? Colors.green : Colors.grey),
              onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen())),


          onItemTapped(0),}
            ),
            IconButton(
              icon: Icon(Icons.favorite, color: selectedIndex == 1 ? Colors.green : Colors.grey),
              onPressed: () {
                Navigator.pushNamed(context, "/favorites");
                onItemTapped(1);
              },
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: Icon(Icons.history, color: selectedIndex == 3 ? Colors.green : Colors.grey),
              onPressed: () => {

                Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryScreen())),

                onItemTapped(3)},
            ),
            IconButton(
              icon: Icon(Icons.person, color: selectedIndex == 4 ? Colors.green : Colors.grey),
              onPressed:
                  () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteCartScreen()));

          onItemTapped(2);
        },
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}