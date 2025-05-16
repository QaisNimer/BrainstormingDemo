import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../controller/favorites_controller.dart';
import '../../../controller/location_controller.dart';
import '../../../model/favorite_model/favorite_model.dart';
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
  int selectedIndex3 = 1; // Set to 1 to select Favorites tab

  @override
  void initState() {
    super.initState();
    // Refresh favorites data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final favoritesController = Provider.of<FavoritesController>(context, listen: false);
      favoritesController.loadFavorites();
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
      appBar: _buildAppBar(context, isDarkMode),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(context, isDarkMode),
            const SizedBox(height: 15),
            _buildFavoritesHeader(context, isDarkMode),
            const SizedBox(height: 5),
            _buildFavoritesContent(context, isDarkMode, screenWidth),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context, isDarkMode),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Extracted methods for better organization and readability

  AppBar _buildAppBar(BuildContext context, bool isDarkMode) {
    return AppBar(
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
                  builder: (context) => const ClientLocationScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.location_on,
              color: isDarkMode ? Colors.white : Colors.green,
              size: 31,
            ),
          ),
          const SizedBox(width: 5),
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
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: isDarkMode ? Colors.white : Colors.black,
              size: 31,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDarkMode) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.search_menu_restaurant_or_etc,
        prefixIcon: Icon(
          Icons.search,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FilterScreen()),
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
    );
  }

  Widget _buildFavoritesHeader(BuildContext context, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.favorite,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        Consumer<FavoritesController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.green,
                ),
              );
            }

            return TextButton(
              onPressed: () {
                controller.loadFavorites();
              },
              child: Text(
                AppLocalizations.of(context)!.refresh,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFavoritesContent(BuildContext context, bool isDarkMode, double screenWidth) {
    return Consumer<FavoritesController>(
      builder: (context, favoritesController, child) {
        // Show error if there is one
        if (favoritesController.error.isNotEmpty) {
          return _buildErrorState(context, isDarkMode, favoritesController);
        }

        // Show loading indicator
        if (favoritesController.isLoading) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
          );
        }

        // Show empty state if no favorites
        if (favoritesController.favorites.isEmpty) {
          return _buildEmptyState(context, isDarkMode);
        }

        // Show favorites grid
        return _buildFavoritesGrid(context, favoritesController, screenWidth);
      },
    );
  }

  Widget _buildErrorState(BuildContext context, bool isDarkMode, FavoritesController controller) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red[400],
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.error_loading_favorites,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                controller.error,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  controller.loadFavorites();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(AppLocalizations.of(context)!.try_again),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDarkMode) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: isDarkMode ? Colors.white54 : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.no_favorites_yet,
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.browse_items_and_mark_favorites,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDarkMode ? Colors.white60 : Colors.black45,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: Text(AppLocalizations.of(context)!.browse_items),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesGrid(BuildContext context, FavoritesController controller, double screenWidth) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => controller.loadFavorites(),
        color: Colors.green,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: screenWidth / (screenWidth * 1.3),
          ),
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final item = controller.favorites[index];
            return FoodCard2Widget(
              title: item.title,
              description: item.description,
              price: item.price,
              imagePath: item.imagePath,
              rating: item.rating,
              isRed: true,
              itemId: item.itemId,
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context, bool isDarkMode) {
    return BottomAppBar(
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
              isSelected: selectedIndex3 == 0,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
                onItemTapped3(0);
              },
            ),
            BottomNavItemWidget(
              icon: Icons.favorite,
              label: AppLocalizations.of(context)!.favorite,
              isSelected: selectedIndex3 == 1,
              onTap: () {
                // Already on favorites screen
                onItemTapped3(1);
              },
            ),
            const SizedBox(width: 40), // space for FAB
            BottomNavItemWidget(
              icon: Icons.history,
              label: AppLocalizations.of(context)!.history,
              isSelected: selectedIndex3 == 2,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryScreen()),
                );
                onItemTapped3(2);
              },
            ),
            BottomNavItemWidget(
              icon: Icons.person,
              label: AppLocalizations.of(context)!.profile,
              isSelected: selectedIndex3 == 3,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
                onItemTapped3(3);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DeleteCartScreen()),
        );
      },
      child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
    );
  }
}