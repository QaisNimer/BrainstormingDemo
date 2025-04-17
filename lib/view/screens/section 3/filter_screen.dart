import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/section%206/profile_screen.dart';
import '../../widgets/bottom_nav_Item_widget.dart';
import '../section 5/client_location_screen.dart';
import '../section 4/delete_cart_screen.dart';
import 'favorites_screen.dart';
import '../section 4/history_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int selectedIndex2 = 0;

  void onItemTapped2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  double minPrice = 0;
  double maxPrice = 100;
  double minDiscount = 0;
  double maxDiscount = 50;
  int selectedLocation = 1;

  List<String> categories = ["Fast Food", "Sea Food", "Dessert"];
  String selectedCategory = "Sea Food";

  List<String> dishes = [
    "Tuna Tartare",
    "Spicy Crab Cakes",
    "Seafood Paella",
    "Clam Chowder",
    "Miso-Glazed Cod",
    "Lobster Thermidor",
  ];
  String selectedDish = "Spicy Crab Cakes";

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
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
                Text(AppLocalizations.of(context)!.current_location, style: TextStyle(fontSize: 15, color: isDarkMode ? Colors.white : Colors.black)),
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
      body: Container(
        color: isDarkMode ? Colors.black : Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.filter,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
                ),
                SizedBox(height: 6),
                Text(
                  AppLocalizations.of(context)!.price_range,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[800] : Colors.white,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.min,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            hintStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[800] : Colors.white,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.max,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            hintStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$0", style: TextStyle(color: isDarkMode ? Colors.white : Colors.grey)),
                    Text("\$10", style: TextStyle(color: isDarkMode ? Colors.white : Colors.grey)),
                  ],
                ),
                RangeSlider(
                  values: RangeValues(minPrice, maxPrice),
                  min: 0,
                  max: 100,
                  activeColor: Colors.green,
                  onChanged: (RangeValues values) {
                    setState(() {
                      minPrice = values.start;
                      maxPrice = values.end;
                    });
                  },
                ),
                Text(
                  AppLocalizations.of(context)!.discount,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[800] : Colors.white,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.min,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            hintStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[800] : Colors.white,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.max,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            hintStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$0", style: TextStyle(color: isDarkMode ? Colors.white : Colors.grey)),
                    Text("50%", style: TextStyle(color: isDarkMode ? Colors.white : Colors.grey)),
                  ],
                ),
                Slider(
                  value: minDiscount,
                  min: 0,
                  max: 50,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      minDiscount = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.category,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
                ),
                Wrap(
                  spacing: 10,
                  children:
                  categories.map((category) {
                    return ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      selectedColor: Colors.green,
                      backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color:
                        selectedCategory == category
                            ? Colors.white
                            : isDarkMode ? Colors.white : Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      showCheckmark: false,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.location,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
                ),
                Wrap(
                  spacing: 8,
                  children:
                  [1, 5, 10].map((km) {
                    return ChoiceChip(
                      label: Text('${km} ${AppLocalizations.of(context)!.km}'),
                      selected: selectedLocation == km,
                      selectedColor: Colors.green,
                      backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color:
                        selectedLocation == km
                            ? Colors.white
                            : isDarkMode ? Colors.white : Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      showCheckmark: false,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedLocation = km;
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.dish,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
                ),
                Wrap(
                  spacing: 20,
                  children:
                  dishes.map((dish) {
                    return ChoiceChip(
                      label: Text(dish),
                      selected: selectedDish == dish,
                      selectedColor: Colors.green,
                      backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color:
                        selectedDish == dish
                            ? Colors.white
                            : isDarkMode ? Colors.white : Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      showCheckmark: false,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedDish = dish;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
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
              const SizedBox(width: 40), // space for FAB
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
        onPressed:
            () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DeleteCartScreen()),
          ),
          onItemTapped2(2),
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
