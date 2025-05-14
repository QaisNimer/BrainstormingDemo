import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodtek/service/item/top_rated_service.dart';
import 'package:foodtek/service/item/top_recommended_service.dart';
import 'package:foodtek/view/screens/section_3/burger_home_screen.dart';
import 'package:foodtek/view/screens/section_3/pizza_home_screen.dart';
import 'package:foodtek/view/widgets/bottom_nav_Item_widget.dart';
import 'package:foodtek/view/widgets/category_button_widget.dart';
import 'package:foodtek/view/widgets/foods/food_card_widget.dart';
import 'package:foodtek/view/widgets/recommended_card_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../controller/location_controller.dart';
import '../../../core/const_values.dart';
import '../../../model/items/top_rated_model.dart';
import '../../../model/items/top_recommended_model.dart';
import '../section_4/delete_cart_screen.dart';
import '../section_4/history_screen.dart';
import '../section_5/client_location_screen.dart';
import '../section_6/profile_screen.dart';
import 'favorites_screen.dart';
import 'filter_screen.dart';
import 'hotdog_home_screen.dart';
import 'notification_screen.dart';
import 'order_details_screen.dart';

class HomeScreen extends StatefulWidget {
  final LatLng? userLocation;
  final String? addressText;

  const HomeScreen({super.key, this.userLocation, this.addressText});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  int selectedIndex2 = 0;
  final PageController pageController = PageController();
  int currentPage = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onItemTapped2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ClientLocationScreen(),
                  ),
                );
              },
              icon: Icon(Icons.location_on, color: Colors.green, size: 28),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.current_location,
                    style: TextStyle(fontSize: 15, color: textColor),
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
                          color: textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.notifications_none, color: textColor),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(
                        context,
                      )!.search_menu_restaurant_or_etc,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.tune),
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => FilterScreen()),
                        ),
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
                      isSelected: selectedIndex == 0,
                      onPressed: () => onItemTapped(0),
                    ),
                    CategoryButtonWidget(
                      title: '🍔 ${AppLocalizations.of(context)!.burger}',
                      isSelected: selectedIndex == 1,
                      onPressed: () {
                        onItemTapped(1);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => BurgerHomeScreen(itemId: 1,)),
                        );
                      },
                    ),
                    CategoryButtonWidget(
                      title: '🍕 ${AppLocalizations.of(context)!.pizza}',
                      isSelected: selectedIndex == 2,
                      onPressed: () {
                        onItemTapped(2);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => PizzaScreen(itemId: 2,)),
                        );
                      },
                    ),
                    CategoryButtonWidget(
                      title: '🌭 ${AppLocalizations.of(context)!.sandwich}',
                      isSelected: selectedIndex == 3,
                      onPressed: () {
                        onItemTapped(3);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => HotdogHomeScreen(itemId: 3,)),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: screenHeight * 0.2,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: PageView(
                  controller: pageController,
                  onPageChanged: (page) => setState(() => currentPage = page),
                  children: List.generate(
                    5,
                    (_) => Image.asset(
                      "assets/images/offer.pizza.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          currentPage == index
                              ? Colors.green
                              : Colors.grey[300],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.top_rated,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: textColor,
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: screenHeight * 0.275,
                child: FutureBuilder<List<Top_Rated_Model>>(
                  future: fetchTopRatedItems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    if (snapshot.hasError)
                      return Center(child: Text("Error loading items"));
                    if (!snapshot.hasData || snapshot.data!.isEmpty)
                      return Center(child: Text("No top-rated items found."));

                    final items = snapshot.data!;
                    final List<String> localImages = [
                      "assets/images/piperonal_pizza.png",
                      "assets/images/cocacola.png",
                      "assets/images/cheeseBruger.png",
                    ];

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final imagePath = (item.image != null && item.image!.isNotEmpty)
                            ? "${ConstValue.baseUrl}${item.image}"
                            : (index < localImages.length
                            ? localImages[index]
                            : "assets/images/default_food.png");

                        return FoodCardWidget(
                          title: item.englishName ?? 'N/A',
                          description: item.englishDescription ?? '',
                          price: item.price?.toString() ?? '0.00',
                          imagePath: imagePath,
                          rating: item.rate?.toDouble() ?? 0.0,
                          onPressed: () {
                            print('Selected item ID: ${item.id}'); // ✅ Show ID for database

                            // ✅ Navigate to different screens based on index
                            if (index == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PizzaScreen(itemId: item.id),
                                ),
                              );
                            } else if (index == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HotdogHomeScreen(itemId: item.id),
                                ),
                              );
                            } else if (index == 2) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BurgerHomeScreen(itemId: item.id),
                                ),
                              );
                            } else {
                              // default fallback for other items
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BurgerHomeScreen(itemId: item.id),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.recommend,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.view_all,
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.15,
                child: FutureBuilder<List<Top_Recommended_Model>>(
                  future: TopRecommendedService().fetchTopRecommendedItems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    if (snapshot.hasError)
                      return Center(child: Text("Error loading recommended items"));
                    if (!snapshot.hasData || snapshot.data!.isEmpty)
                      return Center(child: Text("No recommended items."));

                    final items = snapshot.data!;
                    final fallbackImages = [
                      "assets/images/suchi.png",
                      "assets/images/rice.png",
                      "assets/images/pasta.png",
                      "assets/images/cake.png",
                    ];

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length < 4 ? items.length : 4,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        final imagePath = (item.image != null && item.image.toString().isNotEmpty)
                            ? "${ConstValue.baseUrl}${item.image}"
                            : fallbackImages[index % fallbackImages.length]; // Rotate if less

                        return RecommendedCardWidget(
                          imagePath: imagePath,
                          price: "\$${item.price?.toStringAsFixed(2) ?? '0.00'}",
                        );
                      },
                    );
                  },
                ),
              )

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: bgColor,
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
                isSelected: selectedIndex2 == 0,
                onTap: () => onItemTapped2(0),
              ),
              BottomNavItemWidget(
                icon: Icons.favorite,
                label: AppLocalizations.of(context)!.favorite,
                isSelected: selectedIndex2 == 1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FavoritesScreen()),
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
                    MaterialPageRoute(builder: (_) => HistoryScreen()),
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
                    MaterialPageRoute(builder: (_) => ProfileScreen()),
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
            MaterialPageRoute(builder: (_) => DeleteCartScreen()),
          );
          onItemTapped2(2);
        },
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
