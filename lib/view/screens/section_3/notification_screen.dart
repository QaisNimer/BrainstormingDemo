import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodtek/controller/location_controller.dart';
import 'package:foodtek/model/notification_model.dart';
import 'package:foodtek/service/notification_service.dart';
import 'package:foodtek/view/screens/section_3/filter_screen.dart';
import 'package:foodtek/view/screens/section_3/home_screen.dart';
import 'package:foodtek/view/screens/section_5/client_location_screen.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedTab = 0;
  late Future<List<NotificationModel>> _notificationsFuture;
  List<NotificationModel> allNotifications = [];

  int userId = 1; // ✅ You should fetch this dynamically or inject it

  @override
  void initState() {
    super.initState();
    // Replace the hardcoded userId if you're storing it dynamically
    _notificationsFuture = NotificationService().fetchNotifications(userId);
  }

  void onTabChanged(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  List<NotificationModel> _filterNotifications() {
    if (selectedTab == 1) {
      return allNotifications.where((n) => n.isRead == false).toList();
    } else if (selectedTab == 2) {
      return allNotifications.where((n) => n.isRead == true).toList();
    }
    return allNotifications;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final location = Provider.of<LocationController>(context).address;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ClientLocationScreen()));
              },
              icon: Icon(Icons.location_on, color: Colors.green, size: 31),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.current_location,
                    style: const TextStyle(fontSize: 15)),
                Text(
                  location.isNotEmpty
                      ? location
                      : AppLocalizations.of(context)!.set_location,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.notifications_none, size: 31),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Search menu, restaurant or etc",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => FilterScreen()));
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => HomeScreen()));
                  },
                ),
                const Center(
                  child: Text("Notifications", style: TextStyle(fontSize: 29)),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
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
              child: FutureBuilder<List<NotificationModel>>(
                future: _notificationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Failed to load notifications"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No notifications"));
                  }

                  allNotifications = snapshot.data!;
                  final filtered = _filterNotifications();

                  return ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final notification = filtered[index];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[850] : Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: isDarkMode
                                  ? Colors.grey.withOpacity(0.4)
                                  : Colors.grey.withOpacity(0.2),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            if (notification.isRead == false)
                              Container(
                                width: 11,
                                height: 10,
                                margin: const EdgeInsets.only(right: 9),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                              ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(notification.title ?? '',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black)),
                                  const SizedBox(height: 4),
                                  Text(notification.content ?? '',
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? Colors.white70
                                              : Colors.black87)),
                                  const SizedBox(height: 4),
                                  Text(notification.date ?? '',
                                      style:
                                      const TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
          Text(label,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.green : Colors.black)),
          if (isSelected)
            Container(height: 2, width: 30, color: Colors.green),
        ],
      ),
    );
  }
}
