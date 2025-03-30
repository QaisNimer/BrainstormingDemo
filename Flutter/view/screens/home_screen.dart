import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/client_location_screen.dart';
import 'package:foodtek/view/screens/delete_cart_screen.dart';
import 'package:foodtek/view/screens/favorites_screen.dart';
import 'package:foodtek/view/screens/history_screen.dart';
import 'package:foodtek/view/screens/notification_screen.dart';
import 'package:foodtek/view/screens/order_details_screen.dart';
import 'package:foodtek/view/screens/pizza_home_screen.dart';
import 'package:foodtek/view/widgets/food_card_widget.dart';
import 'package:foodtek/view/widgets/recommended_card_widget.dart';
import '../widgets/category_button_widget.dart';
import 'filter_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientLocationScreen()));
              },
              icon: Icon(Icons.location_on, color: Colors.green, size: 31),
            ),
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
                    hintText: "Search menu, restaurant or etc",
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilterScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.tune),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.grey[200],
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
                      title: "All",
                      isSelected: selectedIndex == 0,
                      onPressed: () => onItemTapped(0),
                    ),
                    CategoryButtonWidget(
                      title: "Burger",

                      icon: Icons.lunch_dining_sharp,
                      isSelected: selectedIndex == 1,
                      onPressed:
                          () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailsScreen(),
                              ),
                            ),

                            onItemTapped(1),
                          },
                    ),
                    CategoryButtonWidget(
                      title: "Pizza",
                      icon: Icons.local_pizza,
                      isSelected: selectedIndex == 2,
                      onPressed:
                          () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PizzaScreen(),
                              ),
                            ),
                            onItemTapped(2),
                          },
                    ),
                    CategoryButtonWidget(
                      title: "Sandwich",
                      icon: Icons.fastfood,
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
                "Top Rated",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: screenHeight * 0.55 / 2,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    FoodCardWidget(
                      title: "Chicken burger",
                      description: "100 gr chicken + tomato + cheese + Lettuce",
                      price: "20.00",
                      imagePath: "assets/images/burger1.png",
                      rating: 3.8,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsScreen(),
                          ),
                        );
                      },
                    ),
                    FoodCardWidget(
                      title: "Cheese burger",
                      description:
                          "100 gr meat + onion + tomato + Lettuce cheese",
                      price: "15.00",
                      imagePath: "assets/images/burger2.png",
                      rating: 4.5,
                      onPressed: () {},
                    ),
                    FoodCardWidget(
                      title: "Chicken burger",
                      description: "100 gr chicken + tomato + cheese + Lettuce",
                      price: "20.00",
                      imagePath: "assets/images/burger1.png",
                      rating: 3.8,
                      onPressed: () {},
                    ),
                    FoodCardWidget(
                      title: "cheese burger",
                      description: "100 gr chicken + tomato + cheese + Lettuce",
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
                    "Recommend",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "View All",
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
                    RecommendedCardWidget(
                      imagePath: "assets/images/suchi.png",
                      price: "\$103.0",
                    ),
                    RecommendedCardWidget(
                      imagePath: "assets/images/rice.png",
                      price: "\$50.0",
                    ),
                    RecommendedCardWidget(
                      imagePath: "assets/images/pasta.png",
                      price: "\$12.99",
                    ),
                    RecommendedCardWidget(
                      imagePath: "assets/images/cake.png",
                      price: "\$8.20",
                    ),
                  ],
                ),
              ),
            ],
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
              icon: Icon(
                Icons.home,
                color: selectedIndex2 == 0 ? Colors.green : Colors.grey,
              ),
              onPressed: () => {onItemTapped2(0)},
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: selectedIndex2 == 1 ? Colors.green : Colors.grey,
              ),
              onPressed:
                  () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoritesScreen(),
                      ),
                    ),

                    onItemTapped2(1),
                  },
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(
                Icons.history,
                color: selectedIndex2 == 3 ? Colors.green : Colors.grey,
              ),
              onPressed: () => {

              Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryScreen())),


                onItemTapped2(3)},
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: selectedIndex2 == 4 ? Colors.green : Colors.grey,
              ),
              onPressed: () => {onItemTapped2(4)},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteCartScreen()));

          onItemTapped2(2);
        },
        child: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
