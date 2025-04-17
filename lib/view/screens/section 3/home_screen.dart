import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/section%205/client_location_screen.dart';
import 'package:foodtek/view/screens/section%204/delete_cart_screen.dart';
import 'package:foodtek/view/screens/section%203/favorites_screen.dart';
import 'package:foodtek/view/screens/section%204/history_screen.dart';
import 'package:foodtek/view/screens/section%203/notification_screen.dart';
import 'package:foodtek/view/screens/section%203/order_details_screen.dart';
import 'package:foodtek/view/screens/section%203/pizza_home_screen.dart';
import 'package:foodtek/view/screens/section%206/profile_screen.dart';
import 'package:foodtek/view/widgets/foods/food_card_widget.dart';
import 'package:foodtek/view/widgets/recommended_card_widget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../widgets/bottom_nav_Item_widget.dart';
import '../../widgets/category_button_widget.dart';
import 'filter_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  String locationAddress = "Fetching location...";

  @override
  void initState() {
    super.initState();
    _getAddressFromLatLng();
  }

  Future<void> _getAddressFromLatLng() async {
    if (widget.userLocation != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          widget.userLocation!.latitude,
          widget.userLocation!.longitude,
        );
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          setState(() {
            locationAddress = "${place.street}, ${place.subLocality}, ${place.locality}";
          });
        }
      } catch (e) {
        setState(() {
          locationAddress = "Failed to get address";
        });
      }
    } else {
      setState(() {
        locationAddress = "Location not available";
      });
    }
  }

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
              icon: Icon(
                Icons.location_on,
                color: Colors.green,
                size: 28,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.current_location,
                    style: TextStyle(fontSize: 13, color: textColor),
                  ),
                  Text(
                    locationAddress,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.notifications_none, color: textColor),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
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
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.search_menu_restaurant_or_etc,
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen()));
                      },
                      icon: Icon(Icons.tune),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                    filled: true,
                  ),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailsScreen()));
                        onItemTapped(1);
                      },
                    ),
                    CategoryButtonWidget(
                      title: '🍕  ${AppLocalizations.of(context)!.pizza}',
                      isSelected: selectedIndex == 2,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PizzaScreen()));
                        onItemTapped(2);
                      },
                    ),
                    CategoryButtonWidget(
                      title: '🌭 ${AppLocalizations.of(context)!.sandwich}',
                      isSelected: selectedIndex == 3,
                      onPressed: () => onItemTapped(3),
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
                  onPageChanged: (int page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  children: List.generate(
                    5,
                        (index) => Image.asset(
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
                      color: currentPage == index ? Colors.green : Colors.grey[300],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.top_rated,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: textColor),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: screenHeight * 0.55 / 2,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    FoodCardWidget(
                      title: AppLocalizations.of(context)!.chicken_burger,
                      description: AppLocalizations.of(context)!.key_100_gr_chicken___tomato___cheese_lettuce,
                      price: "20.00",
                      imagePath: "assets/images/burger1.png",
                      rating: 3.8,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailsScreen()));
                      },
                    ),
                    FoodCardWidget(
                      title: AppLocalizations.of(context)!.cheese_burger,
                      description: AppLocalizations.of(context)!.key_100_gr_meat___onion___tomato___lettuce_cheese,
                      price: "15.00",
                      imagePath: "assets/images/burger2.png",
                      rating: 4.5,
                      onPressed: () {},
                    ),
                    FoodCardWidget(
                      title: AppLocalizations.of(context)!.chicken_burger,
                      description: AppLocalizations.of(context)!.key_100_gr_meat___onion___tomato___lettuce_cheese,
                      price: "20.00",
                      imagePath: "assets/images/burger1.png",
                      rating: 3.8,
                      onPressed: () {},
                    ),
                    FoodCardWidget(
                      title: AppLocalizations.of(context)!.cheese_burger,
                      description: AppLocalizations.of(context)!.key_100_gr_meat___onion___tomato___lettuce_cheese,
                      price: "20.00",
                      imagePath: "assets/images/burger2.png",
                      rating: 3.8,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.recommend,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    RecommendedCardWidget(imagePath: "assets/images/suchi.png", price: "\$103.0"),
                    RecommendedCardWidget(imagePath: "assets/images/rice.png", price: "\$50.0"),
                    RecommendedCardWidget(imagePath: "assets/images/pasta.png", price: "\$12.99"),
                    RecommendedCardWidget(imagePath: "assets/images/cake.png", price: "\$8.20"),
                  ],
                ),
              ),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen()));
                  onItemTapped2(1);
                },
              ),
              const SizedBox(width: 40), // FAB space
              BottomNavItemWidget(
                icon: Icons.history,
                label: AppLocalizations.of(context)!.history,
                isSelected: selectedIndex2 == 3,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen()));
                  onItemTapped2(3);
                },
              ),
              BottomNavItemWidget(
                icon: Icons.person,
                label: AppLocalizations.of(context)!.profile,
                isSelected: selectedIndex2 == 4,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteCartScreen()));
          onItemTapped2(2);
        },
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
