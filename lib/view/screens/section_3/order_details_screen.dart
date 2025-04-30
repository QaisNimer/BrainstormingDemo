import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodtek/view/screens/section_4/delete_cart_screen.dart';
import 'package:foodtek/view/screens/section_6/profile_screen.dart';
import 'package:provider/provider.dart';

import '../../../controller/location_controller.dart';
import '../../widgets/bottom_nav_Item_widget.dart';
import '../section_4/history_screen.dart';
import '../section_5/client_location_screen.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.grey[400] : Colors.grey[700];
    final fillColor = isDark ? Colors.grey[900] : Colors.grey[200];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
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
            SizedBox(width: screenWidth * 0.02), // Dynamic spacing
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.current_location,
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Consumer<LocationController>(
                  builder: (context, locationController, child) {
                    return Text(
                      locationController.address.isNotEmpty
                          ? locationController.address
                          : AppLocalizations.of(context)!.set_location,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    );
                  },
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_drop_down, color: textColor),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.notifications_none, color: textColor, size: 31),
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
      body: SingleChildScrollView(
        // Wrap the body with SingleChildScrollView for scrolling
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ), // Dynamic padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context)!.search_menu_restaurant_or_etc,
                hintStyle: TextStyle(color: secondaryTextColor),
                prefixIcon: Icon(Icons.search, color: textColor),
                suffixIcon: IconButton(
                  icon: Icon(Icons.tune, color: textColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FilterScreen()),
                    );
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: fillColor,
                filled: true,
              ),
              style: TextStyle(color: textColor),
            ),
            SizedBox(height: screenHeight * 0.02), // Dynamic spacing
            Container(child: Image.asset("assets/images/big_burger.png")),
            SizedBox(height: screenHeight * 0.03),
            Text(
              AppLocalizations.of(context)!.cheeseburger_wendys_burger,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
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
                SizedBox(width: 8),
                Text(
                  '4.5 (89 ${AppLocalizations.of(context)!.reviews})',
                  style: TextStyle(color: secondaryTextColor),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
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
                      child: Container(height: 2, color: textColor),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              AppLocalizations.of(context)!.product_description,
              style: TextStyle(color: secondaryTextColor),
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.spicy,
                  style: TextStyle(color: secondaryTextColor),
                ),
                Text(
                  AppLocalizations.of(context)!.quantity,
                  style: TextStyle(color: secondaryTextColor),
                ),
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
                          Text(
                            AppLocalizations.of(context)!.mild,
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            AppLocalizations.of(context)!.hot,
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.1), // Dynamic spacing
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: backgroundColor,
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
                      style: TextStyle(fontSize: 18, color: textColor),
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
            SizedBox(height: screenHeight * 0.02), // Dynamic spacing
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
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.25,
                    vertical: screenHeight * 0.02,
                  ), // Dynamic padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.add_to_cart,
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
        color: backgroundColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: screenHeight * 0.12, // Dynamic bottom navigation bar height
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavItemWidget(
                icon: Icons.home,
                label: AppLocalizations.of(context)!.home,
                isSelected: selectedIndex2 == 0,
                onTap:
                    () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      ),
                      onItemTapped2(0),
                    },
              ),
              BottomNavItemWidget(
                icon: Icons.favorite,
                label: AppLocalizations.of(context)!.favorite,
                isSelected: selectedIndex2 == 1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen()),
                  );
                  onItemTapped2(1);
                },
              ),
              const SizedBox(width: 40),
              BottomNavItemWidget(
                icon: Icons.history,
                label: AppLocalizations.of(context)!.history,
                isSelected: selectedIndex2 == 3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()),
                  );
                  onItemTapped2(3);
                },
              ),
              BottomNavItemWidget(
                icon: Icons.person,
                label: AppLocalizations.of(context)!.profile,
                isSelected: selectedIndex2 == 4,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                  onItemTapped2(4);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DeleteCartScreen()),
          );
          onItemTapped2(2);
        },
        child: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
