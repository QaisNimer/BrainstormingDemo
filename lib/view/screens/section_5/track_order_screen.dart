import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodtek/view/screens/section_6/chat_screen.dart';
import '../../widgets/bottom_nav_Item_widget.dart';
import '../section_3/favorites_screen.dart';
import '../section_4/delete_cart_screen.dart';
import '../section_6/profile_screen.dart';
import '../section_6/track_location_screen.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        title: Text(
          AppLocalizations.of(context)!.order_detail,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/order_icon.png",
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.order_id,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Text("#6579-6432", style: TextStyle(color: Colors.grey)),
                    Text(AppLocalizations.of(context)!.min_25),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                buildOrderStatus(
                  AppLocalizations.of(context)!.order_received,
                  true,
                  Icons.check_circle,
                ),
                buildOrderStatus(
                  AppLocalizations.of(context)!.cooking_your_order,
                  true,
                  Icons.kitchen,
                ),
                buildOrderStatus(
                  AppLocalizations.of(context)!.courier_is_picking_up_order,
                  true,
                  Icons.person,
                ),
                buildOrderStatus(
                  AppLocalizations.of(context)!.order_delivered,
                  false,
                  Icons.home,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/delivery_person.jpg",
                ),
              ),
              title: Text(
                AppLocalizations.of(context)!.aleksandr_v,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              subtitle: Row(
                children: const [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  SizedBox(width: 4),
                  Text("4.9"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: IconButton(
                      icon: const Icon(Icons.call, color: Colors.green),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: IconButton(
                      icon: const Icon(Icons.chat, color: Colors.orange),
                      onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
                      },
                    ),
                  ),
                ],
              ),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.location_on, color: Colors.green),
              title: Text("123 Al-Madina Street, Abdali, Amman, Jordan"),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrackLocationScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  AppLocalizations.of(context)!.live_track,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
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
                onTap: () => onItemTapped(0),
              ),
              BottomNavItemWidget(
                icon: Icons.favorite,
                label: AppLocalizations.of(context)!.favorite,
                isSelected: selectedIndex == 1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesScreen(),
                    ),
                  );
                  onItemTapped(1);
                },
              ),
              const SizedBox(width: 40),
              BottomNavItemWidget(
                icon: Icons.home_work,
                label: AppLocalizations.of(context)!.track,
                isSelected: selectedIndex == 3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrackLocationScreen(),
                    ),
                  );
                  onItemTapped(3);
                },
              ),
              BottomNavItemWidget(
                icon: Icons.person,
                label: AppLocalizations.of(context)!.profile,
                isSelected: selectedIndex == 4,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DeleteCartScreen()),
          );
        },
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildOrderStatus(String title, bool isCompleted, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(icon, color: isCompleted ? Colors.green : Colors.grey),
            if (title != "Order delivered")
              Container(
                width: 2,
                height: 30,
                color: isCompleted ? Colors.green : Colors.grey,
              ),
          ],
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
