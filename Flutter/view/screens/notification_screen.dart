import 'package:flutter/material.dart';
import 'package:untitled/view/screen/home_sceen.dart';
import '../../model/notification_model.dart';
import '../widgets/category_button_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedIndex = 0;
  int selectedTab = 0;

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

  final List<NotificationModel> notifications = [
    NotificationModel(
      title: "Delayed Order:",
      message:
      "We're sorry! Your order is running late. New ETA: 10:30 PM.Thanks for your patience!",
      time: "Last Wednesday at 9:42 AM",
      unread: true,
    ),
    NotificationModel(
      title: "Promotional Offer:",
      message:
      "Craving something delicious? 🍕 Get 20% off on your next order.Use code YUMMY20",
      time: "Last Wednesday at 9:42 AM",
      unread: false,
    ),
    NotificationModel(
      title: "Out for Delivery:",
      message:
      "Your order is on the way! 🚗 Estimated arrival: 15 mins.Stay hungry!",
      time: "Last Wednesday at 9:42 AM",
      unread: false,
    ),
    NotificationModel(
      title: "Order Confirmation:",
      message:
      "Your order has been placed! 🍕 We're preparing it now. Track your order live!",
      time: "Last Wednesday at 9:42 AM",
      unread: false,
    ),
    NotificationModel(
      title: "Delivered:",
      message:
      "Enjoy your meal! 🍕 Your order has been delivered.Rate your experience! ",
      time: "Last Wednesday at 9:42 AM",
      unread: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<NotificationModel> filteredNotifications = notifications;
    if (selectedTab == 1) {
      filteredNotifications = notifications.where((n) => n.unread).toList();
    } else if (selectedTab == 2) {
      filteredNotifications = notifications.where((n) => !n.unread).toList();
    }

    return Scaffold(
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
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            SizedBox(height: 20),
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
                  icon: Icon(Icons.arrow_back),
                ),

                Center(
                  child: Text("Notifications", style: TextStyle(fontSize: 29)),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => onTabChanged(0),
                  child: Column(
                    children: [
                      Text(
                        "All",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                          selectedTab == 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selectedTab == 0 ? Colors.green : Colors.black,
                        ),
                      ),
                      if (selectedTab == 0)
                        Container(height: 2, width: 30, color: Colors.green),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => onTabChanged(1),
                  child: Column(
                    children: [
                      Text(
                        "Unread",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                          selectedTab == 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selectedTab == 1 ? Colors.green : Colors.black,
                        ),
                      ),
                      if (selectedTab == 1)
                        Container(height: 2, width: 30, color: Colors.green),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => onTabChanged(2),
                  child: Column(
                    children: [
                      Text(
                        "Read",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                          selectedTab == 2
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selectedTab == 2 ? Colors.green : Colors.black,
                        ),
                      ),
                      if (selectedTab == 2)
                        Container(height: 2, width: 30, color: Colors.green),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredNotifications.length,
                itemBuilder: (context, index) {
                  final notification = filteredNotifications[index];
                  return Container(
                    //  margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
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
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(notification.message),
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
}