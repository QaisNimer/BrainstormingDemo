import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodtek/view/screens/section_6/profile_screen.dart';
import 'package:foodtek/view/widgets/deliverys/delivery_progress_indicator_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../controller/track_location_controller.dart';
import '../../widgets/bottom_nav_Item_widget.dart';
import '../section_3/favorites_screen.dart';
import '../section_3/home_screen.dart';
import '../section_4/delete_cart_screen.dart';
import 'chat_screen.dart';

class TrackLocationScreen extends StatefulWidget {
  const TrackLocationScreen({super.key});

  @override
  State<TrackLocationScreen> createState() => _TrackLocationScreenState();
}

class _TrackLocationScreenState extends State<TrackLocationScreen> {
  int selectedIndex2 = 0;
  late GoogleMapController mapController;
  final TrackLocationController controller = TrackLocationController();
  int currentStep = 1;

  @override
  void initState() {
    super.initState();
    controller.initializeMap().then((_) {
      controller.simulateCarMovement();
      setState(() {});
    });
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onItemTapped2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            child: GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: controller.carPosition,
                zoom: 15.0,
              ),
              markers: controller.markers,
              polylines: controller.polylines,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: MediaQuery.of(context).size.width * 0.4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[800]
                        : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child: Row(
                children: const [
                  Icon(Icons.access_time, color: Colors.green, size: 18),
                  SizedBox(width: 4),
                  Text("25 min", style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 15,
            right: 15,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context)!.find_your_location,
                      prefixIcon: const Icon(Icons.search, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      fillColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[700]
                              : Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              height: MediaQuery.of(context).size.height * 0.37,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[800]
                        : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentStep == 0
                            ? AppLocalizations.of(context)!.order_placed
                            : currentStep == 1
                            ? AppLocalizations.of(context)!.on_the_way
                            : AppLocalizations.of(context)!.delivered,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.all_detail,
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DeliveryProgressIndicatorWidget(currentStep: currentStep),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/delivery_person.jpg",
                      ),
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.your_delivery_hero,
                      style: TextStyle(color: Colors.grey),
                    ),
                    subtitle: Row(
                      children: [
                        Text(AppLocalizations.of(context)!.aleksandr_v),
                        SizedBox(width: 5),
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
                            icon: Icon(Icons.chat, color: Colors.orange),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context)!.your_location,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.green),
                          SizedBox(width: 6),
                          Text(
                            "123 Al-Madina Street, Abdali, Amman, Jordan",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[850]
                : Colors.white,
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
                isSelected: selectedIndex2 == 3,
                onTap: () => onItemTapped2(3),
              ),
              BottomNavItemWidget(
                icon: Icons.favorite,
                label: AppLocalizations.of(context)!.favorite,
                isSelected: selectedIndex2 == 1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesScreen(),
                    ),
                  );
                  onItemTapped2(1);
                },
              ),
              const SizedBox(width: 40),
              BottomNavItemWidget(
                icon: Icons.home_work,
                label: AppLocalizations.of(context)!.track,
                isSelected: selectedIndex2 == 0,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrackLocationScreen(),
                    ),
                  );
                  onItemTapped2(0);
                },
              ),
              BottomNavItemWidget(
                icon: Icons.person,
                label: AppLocalizations.of(context)!.profile,
                isSelected: selectedIndex2 == 4,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
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
            MaterialPageRoute(builder: (context) => const DeleteCartScreen()),
          );
          onItemTapped2(2);
        },
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
