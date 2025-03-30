import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/add_card_screen.dart';
import 'package:foodtek/view/screens/delete_cart_screen.dart';
import 'package:foodtek/view/screens/history_screen.dart';
import 'package:foodtek/view/screens/home_screen.dart';
import '../widgets/cart_total_widget.dart';
import 'favorites_screen.dart';
import 'notification_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int selectedIndex2 = 0;

  void onItemTapped2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  final TextEditingController promoController = TextEditingController();
  double discount = 0.0;
  String selectedPayment = 'card';
  String selectedCardType = 'visa';

  void applyPromoCode() {
    String promoCode = promoController.text.trim();
    setState(() {
      if (promoCode == "10") {
        discount = 10.0;
      } else if (promoCode == "20") {
        discount = 20.0;
      } else {
        discount = 0.0;
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text("Invalid Promo Code"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
    promoController.clear();
  }

  Widget buildSelectionOption({
    required bool isSelected,
    required String label,
    required VoidCallback onTap,
    Widget? icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Selection circle
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.circle_outlined,
                size: 20,
                color: isSelected ? Colors.green : Colors.grey,
              ),
              if (isSelected)
                 Icon(Icons.circle, size: 8, color: Colors.green),
            ],
          ),
           SizedBox(width: 8),
          // Optional icon
          if (icon != null) icon,
          if (icon != null)  SizedBox(width: 8),
          // Label text
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon:  Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 31,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  NotificationScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              "CheckOut",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 10),
             Text(
              "Pay With",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children:  [
                        Icon(
                          Icons.circle_outlined,
                          size: 20,
                          color: Colors.grey,
                        ),
                        Icon(Icons.circle, size: 5, color: Colors.green),
                      ],
                    ),
                     SizedBox(width: 12),
                     Text(
                      "88 Zurab Gorgiladze St",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                 Padding(
                  padding: EdgeInsets.only(left: 36),
                  child: Text(
                    "Georgia, Batumi",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              ],
            ),
             SizedBox(height: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children:  [
                    Icon(Icons.location_on_outlined, color: Colors.green),
                    SizedBox(width: 12),
                    Text("5 Noe Zhordania St", style: TextStyle(fontSize: 16)),
                  ],
                ),
                 Padding(
                  padding: EdgeInsets.only(left: 36),
                  child: Text(
                    "Georgia, Batumi",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child:  Text(
                    "Change",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Promo Code?",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                 SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: promoController,
                        decoration: InputDecoration(
                          hintText: "Enter promo code",
                          border: OutlineInputBorder(
                            borderRadius:  BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          contentPadding:  EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 53,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: applyPromoCode,
                        child:  Text(
                          "Apply",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
             SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Payment Method",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                 SizedBox(height: 10),
                Row(
                  children: [
                    buildSelectionOption(
                      isSelected: selectedPayment == 'card',
                      label: 'Card',
                      onTap: () => setState(() => selectedPayment = 'card'),
                    ),
                     SizedBox(width: 20),
                    buildSelectionOption(
                      isSelected: selectedPayment == 'cash',
                      label: 'Cash ',
                      onTap: () => setState(() => selectedPayment = 'cash'),
                    ),
                  ],
                ),
              ],
            ),
             SizedBox(height: 20),
            if (selectedPayment == 'card') ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Card Type",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                   SizedBox(height: 10),
                  Row(
                    children: [
                      buildSelectionOption(
                        isSelected: selectedCardType == 'visa',
                        label: '',
                        icon: Image.asset("assets/images/mastercard.png",fit: BoxFit.cover,width: 30,height: 30,),
                        onTap: () => setState(() => selectedCardType = 'visa'),
                      ),
                       SizedBox(width: 20),
                      buildSelectionOption(
                        isSelected: selectedCardType == 'paypal',
                        label: '',
                        icon: Image.asset("assets/images/visa.png",fit: BoxFit.cover,width: 40,height: 40,),
                        onTap: () => setState(() => selectedCardType = 'paypal'),
                      ),
                    ],
                  ),
                ],
              ),
               SizedBox(height: 20),
            ],
            CartTotalWidget(
              subtotal: 100.0,
              delivery: 5.0,
              discount: discount,
              onOrderPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCardScreen()));

              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape:  CircularNotchedRectangle(),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  HomeScreen(),
                  ),
                ),
                onItemTapped2(0)},
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: selectedIndex2 == 1 ? Colors.green : Colors.grey,
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  FavoritesScreen(),
                  ),
                ),
                onItemTapped2(1),
              },
            ),
             SizedBox(width: 40),
            IconButton(
              icon: Icon(
                Icons.history,
                color: selectedIndex2 == 3 ? Colors.green : Colors.grey,
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  HistoryScreen(),
                  ),
                ),
                onItemTapped2(3)},
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: selectedIndex2 == 4 ? Colors.green : Colors.grey,
              ),
              onPressed: () => {onItemTapped2(4)},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteCartScreen()));

          onItemTapped2(2);
        },
        child:  Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}