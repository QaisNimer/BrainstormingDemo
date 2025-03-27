import 'package:flutter/material.dart';
import 'favorites_screen.dart';
import 'history_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.location_on, color: Colors.green, size: 31),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Current location", style: TextStyle(fontSize: 15)),
                Text(
                  "Jl. Soekarno Hatta 15A..",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_drop_down)),
            Spacer(),
            IconButton(
              icon: Icon(Icons.notifications_none, color: Colors.black, size: 31),
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
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Filter", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text("Price range", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Min",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Max",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                    Text("\$0", style: TextStyle(color: Colors.grey)),
                    Text("\$10", style: TextStyle(color: Colors.grey)),
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
                Text("Discount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Min",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Max",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$0", style: TextStyle(color: Colors.grey)),
                    Text("50%", style: TextStyle(color: Colors.grey)),
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
                Text("Category", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 10,
                  children: categories.map((category) {
                    return ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      selectedColor: Colors.green,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: selectedCategory == category ? Colors.white : Colors.black,
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
                Text("Location", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 8,
                  children: [1, 5, 10].map((km) {
                    return ChoiceChip(
                      label: Text("$km KM"),
                      selected: selectedLocation == km,
                      selectedColor: Colors.green,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: selectedLocation == km ? Colors.white : Colors.black,
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
                Text("Dish", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 20,
                  children: dishes.map((dish) {
                    return ChoiceChip(
                      label: Text(dish),
                      selected: selectedDish == dish,
                      selectedColor: Colors.green,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: selectedDish == dish ? Colors.white : Colors.black,
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
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: selectedIndex2 == 0 ? Colors.green : Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite, color: selectedIndex2 == 1 ? Colors.green : Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()),
                );
              },
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(Icons.history, color: selectedIndex2 == 3 ? Colors.green : Colors.grey),
              onPressed: () => {

                Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryScreen())),

                onItemTapped2(3)},
            ),
            IconButton(
              icon: Icon(Icons.person, color: selectedIndex2 == 4 ? Colors.green : Colors.grey),
              onPressed: () => onItemTapped2(4),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onItemTapped2(2),
        backgroundColor: Colors.green,
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}