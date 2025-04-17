import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/section%203/filter_screen.dart';
import 'package:foodtek/view/screens/section%206/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/bottom_nav_Item_widget.dart';
import '../../widgets/foods/food_cart2_widget.dart';
import '../section 5/client_location_screen.dart';
import '../section 4/delete_cart_screen.dart';
import '../section 4/history_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int selectedIndex1 = 0;
  int selectedIndex3 = 0;

  void onItemTapped1(int index1) {
    setState(() {
      selectedIndex1 = index1;
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
              icon: Icon(Icons.location_on, color: isDarkMode ? Colors.white : Colors.green, size: 31),
            ),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.current_location,
                  style: TextStyle(fontSize: 15, color: isDarkMode ? Colors.white : Colors.black),
                ),
                Text(
                  "Jl. Soekarno Hatta 15A..",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_drop_down, color: isDarkMode ? Colors.white : Colors.black)),
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
                prefixIcon: Icon(Icons.search, color: isDarkMode ? Colors.white : Colors.black),
                suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FilterScreen()),
                    );
                  },
                  icon: Icon(Icons.tune, color: isDarkMode ? Colors.white : Colors.black),
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
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: screenWidth / (screenWidth * 1.3),
                children: [
                  FoodCard2Widget(
                    title: AppLocalizations.of(context)!.pepperoni_pizza,
                    description:
                    AppLocalizations.of(
                      context,
                    )!.pepperoni_pizza_margarita_pizza_margherita_italian_cuisine_tomato,
                    price: "29.00",
                    imagePath: "assets/images/pizza (1).png",
                    rating: 4.5,
                    isRed: true,
                  ),
                  FoodCard2Widget(
                    title: AppLocalizations.of(context)!.pizza_cheese,
                    description:
                    AppLocalizations.of(
                      context,
                    )!.food_pizza_dish_cuisine_junk_food_fast_food_flatbread_ingredient,
                    price: "23.00",
                    imagePath: "assets/images/pizza1.png",
                    rating: 4.3,
                    isRed: true,
                  ),
                  FoodCard2Widget(
                    title: AppLocalizations.of(context)!.peppy_paneer,
                    description:
                    AppLocalizations.of(
                      context,
                    )!.chunky_paneer_with_crisp_capsicum_and_spicy_red_pepper,
                    price: "13.00",
                    imagePath: "assets/images/pizza2.png",
                    rating: 4.2,
                    isRed: true,
                  ),
                  FoodCard2Widget(
                    title: AppLocalizations.of(context)!.mexican_green_wave,
                    description:
                    AppLocalizations.of(
                      context,
                    )!.a_pizza_loaded_with_crunchy_onions_crisp_capsicum_juicy_tomatoes,
                    price: "23.00",
                    imagePath: "assets/images/pizza3.png",
                    rating: 4.7,
                    isRed: true,
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
