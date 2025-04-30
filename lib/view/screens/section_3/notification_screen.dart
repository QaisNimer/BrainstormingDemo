import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodtek/controller/location_controller.dart';
import 'package:foodtek/view/screens/section_3/filter_screen.dart';
import 'package:foodtek/view/screens/section_3/home_screen.dart';
import 'package:provider/provider.dart';

import '../../../model/notification_model.dart';
import '../section_5/client_location_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedIndex = 0;
  int selectedTab = 0;

  late List<NotificationModel> notifications;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onTabChanged(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notifications = [
      NotificationModel(
        title: AppLocalizations.of(context)!.delayed_order,
        message:
            AppLocalizations.of(
              context,
            )!.we_re_sorry_your_order_is_running_late_new_eta_10_30_PM_thanks_for_your_patience,
        time: AppLocalizations.of(context)!.last_wednesday_at_9_42_am,
        unread: true,
      ),
      NotificationModel(
        title: AppLocalizations.of(context)!.promotional_offer,
        message:
            "🍕 ${AppLocalizations.of(context)!.craving_something_delicious_get_20_off_on_your_next_order_use_code_yummy20}",
        time: AppLocalizations.of(context)!.last_wednesday_at_9_42_am,
        unread: false,
      ),
      NotificationModel(
        title: AppLocalizations.of(context)!.out_for_delivery,
        message:
            "🚗 ${AppLocalizations.of(context)!.your_order_is_on_the_way_estimated_arrival_15_mins_stay_hungry}",
        time: AppLocalizations.of(context)!.last_wednesday_at_9_42_am,
        unread: false,
      ),
      NotificationModel(
        title: AppLocalizations.of(context)!.order_confirmation,
        message:
            "🍕 ${AppLocalizations.of(context)!.your_order_has_been_placed_we_re_preparing_it_now_track_your_order_live}",
        time: AppLocalizations.of(context)!.last_wednesday_at_9_42_am,
        unread: false,
      ),
      NotificationModel(
        title: AppLocalizations.of(context)!.delivered,
        message:
            "🍕 ${AppLocalizations.of(context)!.enjoy_your_meal_your_order_has_been_delivered_rate_your_experience}",
        time: AppLocalizations.of(context)!.last_wednesday_at_9_42_am,
        unread: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final location = Provider.of<LocationController>(context).address;

    List<NotificationModel> filteredNotifications = notifications;
    if (selectedTab == 1) {
      filteredNotifications = notifications.where((n) => n.unread).toList();
    } else if (selectedTab == 2) {
      filteredNotifications = notifications.where((n) => !n.unread).toList();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              icon: Icon(Icons.location_on, color: Colors.green, size: 31),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.current_location,
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  location.isNotEmpty
                      ? location
                      : AppLocalizations.of(context)!.set_location,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.notifications_none, size: 31),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Search menu, restaurant or etc",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FilterScreen()),
                    );
                  },
                  icon: const Icon(Icons.tune),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const Center(
                  child: Text("Notifications", style: TextStyle(fontSize: 29)),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabButton("All", 0),
                _buildTabButton("Unread", 1),
                _buildTabButton("Read", 2),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredNotifications.length,
                itemBuilder: (context, index) {
                  final notification = filteredNotifications[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color:
                              isDarkMode
                                  ? Colors.grey.withOpacity(0.4)
                                  : Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                      color: isDarkMode ? Colors.grey[850] : Colors.white,
                    ),
                    child: Row(
                      children: [
                        if (notification.unread)
                          Container(
                            width: 11,
                            height: 10,
                            margin: const EdgeInsets.fromLTRB(0, 0, 9, 90),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.title,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notification.message,
                                style: TextStyle(
                                  color:
                                      isDarkMode
                                          ? Colors.white70
                                          : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notification.time,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final bool isSelected = selectedTab == index;
    return TextButton(
      onPressed: () => onTabChanged(index),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.green : Colors.black,
            ),
          ),
          if (isSelected) Container(height: 2, width: 30, color: Colors.green),
        ],
      ),
    );
  }
}
