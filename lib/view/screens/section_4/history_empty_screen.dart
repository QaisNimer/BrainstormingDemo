import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../controller/location_controller.dart';
import '../../widgets/bottom_nav_Item_widget.dart';
import '../section_3/favorites_screen.dart';
import '../section_3/notification_screen.dart';
import '../section_6/profile_screen.dart';
import 'cart_empty_screen.dart';
import 'delete_cart_screen.dart';
import 'history_screen.dart';

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
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.location_on, color: Colors.green, size: 31),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.current_location,
                  style: TextStyle(
                    fontSize: 15,
                    color: isDarkMode ? Colors.white : Colors.black,
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
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    );
                  },
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
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartEmptyScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.cart,
                        style: TextStyle(
                          color:
                              selectedTabIndex == 0
                                  ? Colors.green
                                  : Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                      Text(
                        AppLocalizations.of(context)!.history,
                        style: TextStyle(
                          color:
                              selectedTabIndex == 1
                                  ? Colors.green
                                  : Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                Image.asset('assets/images/cart_empty.png', height: 250),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.history_empty,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(
                    context,
                  )!.you_don_t_have_order_any_foods_before,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavItemWidget(
                icon: Icons.home,
                label: AppLocalizations.of(context)!.home,
                isSelected: selectedIndex == 3,
                onTap: () => onItemTapped(3),
              ),
              BottomNavItemWidget(
                icon: Icons.favorite,
                label: AppLocalizations.of(context)!.favorite,
                isSelected: selectedIndex == 1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen()),
                  );
                  onItemTapped(1);
                },
              ),
              const SizedBox(width: 40), // space for FAB
              BottomNavItemWidget(
                icon: Icons.history,
                label: AppLocalizations.of(context)!.history,
                isSelected: selectedIndex == 0,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()),
                  );
                  onItemTapped(0);
                },
              ),
              BottomNavItemWidget(
                icon: Icons.person,
                label: AppLocalizations.of(context)!.profile,
                isSelected: selectedIndex == 4,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                  onItemTapped(4);
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
          onItemTapped(2);
        },
        child: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
