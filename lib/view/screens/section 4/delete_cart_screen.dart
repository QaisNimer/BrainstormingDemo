import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/section%204/cart_empty_screen.dart';
import 'package:foodtek/view/screens/section%205/check_out_screen.dart';
import 'package:foodtek/view/screens/section%203/filter_screen.dart';
import 'package:foodtek/view/screens/section%204/history_screen.dart';
import 'package:foodtek/view/screens/section%206/profile_screen.dart';
import 'package:foodtek/view/widgets/carts/cart_total_widget.dart';
import 'package:foodtek/view/widgets/carts/cart_item_widget.dart';
import '../../widgets/bottom_nav_Item_widget.dart';
import '../section 5/client_location_screen.dart';
import '../section 3/favorites_screen.dart';
import '../section 3/home_screen.dart';
import '../section 3/notification_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteCartScreen extends StatefulWidget {
  const DeleteCartScreen({super.key});

  @override
  State<DeleteCartScreen> createState() => _DeleteCartScreenState();
}

class _DeleteCartScreenState extends State<DeleteCartScreen> {
  int selectedTab = 0;
  int selectedIndex = 0;

  void onTabChanged(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                Text(AppLocalizations.of(context)!.current_location, style: TextStyle(fontSize: 15)),
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => onTabChanged(0),
                    child: Column(
                      children: [
                        Text(
                        AppLocalizations.of(context)!.cart,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                selectedTab == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                selectedTab == 0 ? Colors.green : Colors.black,
                          ),
                        ),
                        if (selectedTab == 0)
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: Colors.green,
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () => {

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryScreen())),
                      onTabChanged(1)},
                    child: Column(
                      children: [
                        Text(
                        AppLocalizations.of(context)!.history,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                selectedTab == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                selectedTab == 1 ? Colors.green : Colors.black,
                          ),
                        ),
                        if (selectedTab == 1)
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: Colors.green,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  CartItemWidget(
                    title: AppLocalizations.of(context)!.spicy_shawarma,
                    subtitle: AppLocalizations.of(context)!.hot_cool_spot,
                    price: 15,
                    image: "assets/images/shawarma.png",
                    onDelete: () {},
                  ),
                  CartItemWidget(
                    title: AppLocalizations.of(context)!.chicken_burger,
                     subtitle:AppLocalizations.of(context)!.burger_factory_ltd,
                    price: 20,
                    image: "assets/images/chicken.burger.png",
                    onDelete: () {},
                  ),
                  CartItemWidget(
                    title: AppLocalizations.of(context)!.onion_pizza,
                    subtitle:AppLocalizations.of(context)!.pizza_palace,
                    price: 15,
                    image: "assets/images/onion.pizza.png",
                    onDelete: () {},
                  ),
                  CartItemWidget(
                    title: AppLocalizations.of(context)!.spicy_shawarma,
                    subtitle: AppLocalizations.of(context)!.hot_cool_spot,
                    price: 15,
                    image: "assets/images/shawarma.png",
                    onDelete: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CartEmptyScreen()));

                    },
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              CartTotalWidget(
                subtotal: 100,
                delivery: 10,
                discount: 10,
                onOrderPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOutScreen()));
                },
              ),
            ],
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
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

                isSelected: selectedIndex == 3,
                onTap: () => onItemTapped(3),
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

                isSelected: selectedIndex == 0,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()),
                  );
                  onItemTapped(0);
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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteCartScreen()));

          onItemTapped(2);
        },
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
