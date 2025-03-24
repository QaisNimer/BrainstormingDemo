import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled/view/screen/favourites_screen.dart';
import 'package:untitled/view/screen/home_sceen.dart';
import 'filter_screen.dart';
import 'notification_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int selectedIndex2 = 0;
  int quantity = 3;
  double spiciness = 0.0;

  void onItemTapped2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.green, size: 31),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Current location", style: TextStyle(fontSize: 15)),
                const Text(
                  "Jl. Soekarno Hatta 15A..",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.notifications_none, size: 31, color: Colors.black),
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
                          MaterialPageRoute(builder: (context) => FilterScreen()),
                        );
                      },
                      icon: Icon(Icons.filter_list),
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
              const SizedBox(height: 20),
              Center(child: Image.asset("assets/images/big_burger.png", height: 220)),
              const SizedBox(height: 20),
              const Text(
                "Cheeseburger Wendy's Burger",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: 4.5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25,
                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {},
                  ),
                  const SizedBox(width: 5),
                  const Text("4.5   (89 reviews)", style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 10),


              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("\$7.99", style: TextStyle(fontSize: 26, color: Colors.green)),
                  const SizedBox(width: 10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Text("\$9.5", style: TextStyle(fontSize: 21, color: Colors.green)),
                      Container(height: 2, color: Colors.black, width: 35),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),


              const Text(
                "Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 18),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Spicy", style: TextStyle(color: Colors.grey)),
                  Text("Quantity", style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Slider(
                          value: spiciness,
                          min: 0,
                          max: 10,
                          activeColor: Colors.red,
                          onChanged: (value) {
                            setState(() {
                              spiciness = value;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Mild", style: TextStyle(color: Colors.green)),
                            Text("Hot", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 60),

                  Row(
                    children: [
                      // ➖ Button
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.green, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.remove, size: 18, color: Colors.green),
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) quantity--;
                            });
                          },
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      const SizedBox(width: 10),

                      // 🔢 Quantity Text
                      Text(quantity.toString(), style: const TextStyle(fontSize: 18, color: Colors.black)),
                      const SizedBox(width: 10),

                      // ➕ Button
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.green, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.add, size: 18, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),


              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Add To Cart",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
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
            const SizedBox(width: 40),
            IconButton(
              icon: Icon(Icons.history, color: selectedIndex2 == 3 ? Colors.green : Colors.grey),
              onPressed: () => onItemTapped2(3),
            ),
            IconButton(
              icon: Icon(Icons.person, color: selectedIndex2 == 4 ? Colors.green : Colors.grey),
              onPressed: () => onItemTapped2(4),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => onItemTapped2(2),
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
