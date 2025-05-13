import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../controller/favorites_controller.dart';
import '../../../controller/location_controller.dart';
import '../../widgets/bottom_nav_Item_widget.dart';
import '../../widgets/foods/food_cart2_widget.dart';
import '../section_4/delete_cart_screen.dart';
import '../section_4/history_screen.dart';
import '../section_5/client_location_screen.dart';
import '../section_6/profile_screen.dart';
import 'filter_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int selectedIndex3 = 0;

  @override
  void initState() {
    super.initState();
    // Load favorites when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavoritesController>(context, listen: false).loadFavorites();
    });
  }

  void onItemTapped3(int index3) {
    setState(() {
      selectedIndex3 = index3;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
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
              icon: Icon(
                Icons.location_on,
                color: isDarkMode ? Colors.white : Colors.green,
                size: 31,
              ),
            ),
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
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_drop_down,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: isDarkMode ? Colors.white : Colors.black,
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText:
                AppLocalizations.of(context)!.search_menu_restaurant_or_etc,
                prefixIcon: Icon(
                  Icons.search,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FilterScreen()),
                    );
                  },
                  icon: Icon(
                    Icons.tune,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                filled: true,
              ),
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.favorite,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<FavoritesController>(
                builder: (context, favoritesController, child) {
                  if (favoritesController.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (favoritesController.error.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Error loading favorites',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white70 : Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              favoritesController.loadFavorites();
                            },
                            child: Text('Retry'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final favorites = favoritesController.favorites;

                  if (favorites.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.no_favorites_yet,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  return GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: screenWidth / (screenWidth * 1.3),
                    children: favorites.map((item) {
                      // Get the itemId from the controller
                      int itemId = favoritesController.getItemIdByTitle(item.title);

                      return FoodCard2Widget(
                        title: item.title,
                        description: item.description,
                        price: item.price,
                        imagePath: item.imagePath,
                        rating: item.rating,
                        isRed: true,
                        itemId: itemId,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: isDarkMode ? Colors.black : Colors.white,
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
                isSelected: selectedIndex3 == 1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                  onItemTapped3(1);
                },
              ),
              BottomNavItemWidget(
                icon: Icons.favorite,
                label: AppLocalizations.of(context)!.favorite,
                isSelected: selectedIndex3 == 0,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen()),
                  );
                  onItemTapped3(0);
                },
              ),
              const SizedBox(width: 40), // space for FAB
              BottomNavItemWidget(
                icon: Icons.history,
                label: AppLocalizations.of(context)!.history,
                isSelected: selectedIndex3 == 3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()),
                  );
                  onItemTapped3(3);
                },
              ),
              BottomNavItemWidget(
                icon: Icons.person,
                label: AppLocalizations.of(context)!.profile,
                isSelected: selectedIndex3 == 4,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                  onItemTapped3(4);
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
        },
        child: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}