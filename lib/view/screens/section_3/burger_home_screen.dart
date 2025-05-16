import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../controller/location_controller.dart';
import '../../../controller/category_controller.dart';
import '../../widgets/bottom_nav_Item_widget.dart';
import '../../widgets/foods/food_cart2_widget.dart';
import '../section_4/delete_cart_screen.dart';
import '../section_4/history_screen.dart';
import '../section_5/client_location_screen.dart';
import '../section_6/profile_screen.dart';
import 'favorites_screen.dart';
import 'filter_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';

class BurgerHomeScreen extends StatefulWidget {
  final int itemId;

  const BurgerHomeScreen({required this.itemId, super.key});

  @override
  State<BurgerHomeScreen> createState() => _BurgerHomeScreenState();
}

class _BurgerHomeScreenState extends State<BurgerHomeScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryController>(context, listen: false)
          .fetchCategoryItems('Burger');
    });
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final locationController = Provider.of<LocationController>(context);

    return Scaffold(
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
                        builder: (context) => ClientLocationScreen()));
              },
              icon: const Icon(Icons.location_on, color: Colors.green, size: 31),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.current_location,
                    style: TextStyle(
                      fontSize: 15,
                      color: theme.textTheme.bodyMedium!.color,
                    ),
                  ),
                  Text(
                    locationController.address,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: theme.textTheme.bodyLarge!.color,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.notifications_none,
                  color: theme.iconTheme.color, size: 31),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!
                    .search_menu_restaurant_or_etc,
                prefixIcon: Icon(Icons.search, color: theme.iconTheme.color),
                suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FilterScreen()));
                  },
                  icon: Icon(Icons.tune, color: theme.iconTheme.color),
                ),
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<CategoryController>(
                builder: (context, categoryController, _) {
                  if (categoryController.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (categoryController.errorMessage != null) {
                    return Center(
                        child: Text(categoryController.errorMessage!));
                  }

                  final categoryItems = categoryController.categoryItems;
                  if (categoryItems.isEmpty) {
                    return Center(
                      child: Text(AppLocalizations.of(context)!.no_items_available),
                    );
                  }

                  return GridView.builder(
                    itemCount: categoryItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: screenWidth / (screenWidth * 1.3),
                    ),
                    itemBuilder: (context, index) {
                      final item = categoryItems[index];
                      return FoodCard2Widget(
                        title: item.englishName,
                        description: item.arabicName,
                        price: "15.00", // Replace with item price if available
                        imagePath: item.imagePath ?? 'assets/images/default.png',
                        rating: 4.5, // Replace with item rating if available
                        itemId: widget.itemId,
                      );
                    },
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
                isSelected: selectedIndex == 0,
                onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => HomeScreen())),
              ),
              BottomNavItemWidget(
                icon: Icons.favorite,
                label: AppLocalizations.of(context)!.favorite,
                isSelected: selectedIndex == 1,
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => FavoritesScreen())),
              ),
              const SizedBox(width: 40),
              BottomNavItemWidget(
                icon: Icons.person,
                label: AppLocalizations.of(context)!.profile,
                isSelected: selectedIndex == 4,
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ProfileScreen())),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DeleteCartScreen()),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
