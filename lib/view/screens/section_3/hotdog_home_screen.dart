import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodtek/view/screens/section_3/pizza_home_screen.dart';
import 'package:provider/provider.dart';

import '../../../controller/location_controller.dart';
import '../../widgets/bottom_nav_Item_widget.dart';
import '../../widgets/category_button_widget.dart';
import '../../widgets/foods/food_card_widget.dart';
import '../../widgets/foods/food_cart2_widget.dart';
import '../section_4/delete_cart_screen.dart';
import '../section_4/history_screen.dart';
import '../section_5/client_location_screen.dart';
import '../section_6/profile_screen.dart';
import 'burger_home_screen.dart';
import 'favorites_screen.dart';
import 'filter_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';
import 'order_details_screen.dart';

class HotdogHomeScreen extends StatefulWidget {
  final int itemId;

  const HotdogHomeScreen({required this.itemId, super.key});

  @override
  State<HotdogHomeScreen> createState() => _HotdogHomeScreenState();
}

class _HotdogHomeScreenState extends State<HotdogHomeScreen> {
  int selectedIndex = 0;
  final int selectedCategoryIndex = 2;
  bool isFavoriteSelected = false;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final locationController = Provider.of<LocationController>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
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
                Text(
                  AppLocalizations.of(context)!.current_location,
                  style: TextStyle(
                    fontSize: 15,
                    color: theme.textTheme.bodyMedium!.color,
                  ),
                ),
                // عرض العنوان من LocationController
                Text(
                  locationController.address, // العنوان من LocationController
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: theme.textTheme.bodyLarge!.color,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_drop_down, color: theme.iconTheme.color),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: theme.iconTheme.color,
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
                hintStyle: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black45,
                ),
                prefixIcon: Icon(Icons.search, color: theme.iconTheme.color),
                suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FilterScreen()),
                    );
                  },
                  icon: Icon(Icons.tune, color: theme.iconTheme.color),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                filled: true,
              ),
            ),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryButtonWidget(
                    title: AppLocalizations.of(context)!.all,
                    isSelected: false,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                  CategoryButtonWidget(
                    title: '🍔 ${AppLocalizations.of(context)!.burger}',
                    isSelected: false,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BurgerHomeScreen(itemId: 1,),
                        ),
                      );
                    },
                  ),
                  CategoryButtonWidget(
                    title: '🍕  ${AppLocalizations.of(context)!.pizza}',
                    isSelected: false,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PizzaScreen(itemId: 2,)),
                      );
                    },
                  ),
                  CategoryButtonWidget(
                    title: '🌭 ${AppLocalizations.of(context)!.sandwich}',
                    isSelected: true,
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HotdogHomeScreen(itemId: 3,)),
                      );


                    },
                  ),
                ],
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
                    title: AppLocalizations.of(context)!.classic_american_hotdog,
                    description: AppLocalizations.of(context)!.classic_american_hotdog_desc,
                    price: "20.00",
                    imagePath: "assets/images/hotdog1.jpeg",
                    rating: 3.8,
                    itemId: 1, // Example itemId, adjust accordingly
                  ),
                  FoodCard2Widget(
                    title: AppLocalizations.of(context)!.chicago_style_hotdog,
                    description: AppLocalizations.of(context)!.chicago_style_hotdog_desc,
                    price: "15.00",
                    imagePath: "assets/images/hotdog2.jpeg",
                    rating: 4.5,
                    itemId: 2, // Example itemId, adjust accordingly
                  ),
                  FoodCard2Widget(
                    title: AppLocalizations.of(context)!.chili_cheese_dog,
                    description: AppLocalizations.of(context)!.chili_cheese_dog_desc,
                    price: "20.00",
                    imagePath: "assets/images/hotdog3.jpeg",
                    rating: 3.8,
                    itemId: 3, // Example itemId, adjust accordingly
                  ),
                  FoodCard2Widget(
                    title: AppLocalizations.of(context)!.bacon_wrapped_hotdog,
                    description: AppLocalizations.of(context)!.bacon_wrapped_hotdog_desc,
                    price: "20.00",
                    imagePath: "assets/images/hotdog4.jpeg",
                    rating: 3.8,
                    itemId: 4, // Example itemId, adjust accordingly
                  ),
                ],

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
                isSelected: selectedIndex == 0,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                  onItemTapped(0);
                },
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
                isSelected: selectedIndex == 3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()),
                  );
                  onItemTapped(3);
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
        },
        child: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
