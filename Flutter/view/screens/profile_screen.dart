import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/home_screen.dart';
import 'package:foodtek/view/screens/login_screen.dart';
import 'delete_cart_screen.dart';
import 'favorites_screen.dart';
import 'history_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex2 = 0;

  void onItemTapped2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  bool pushNotifications = true;
  bool promotionalNotifications = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.02),
              CircleAvatar(
                radius: screenWidth * 0.15,
                backgroundImage: AssetImage("assets/images/profile.png"),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Ahmad Daboor",
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "ahmad1709@gmail.com",
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Account",
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person_outline,
                          size: screenWidth * 0.06,
                        ),
                        title: Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.language, size: screenWidth * 0.06),
                        title: Text(
                          "Language",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          
                        ),
                        trailing: TextButton(onPressed: (){}, child: Text("عربية")),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.privacy_tip_outlined,
                          size: screenWidth * 0.06,
                        ),
                        title: Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.settings_outlined,
                          size: screenWidth * 0.06,
                        ),
                        title: Text(
                          "Settings",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.notifications_none,
                        size: screenWidth * 0.06,
                      ),
                      title: Text(
                        "Push Notifications",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: pushNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              pushNotifications = value;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.notifications_none,
                        size: screenWidth * 0.06,
                      ),
                      title: Text(
                        "Promotional Notifications",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: promotionalNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              promotionalNotifications = value;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "More ",
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.privacy_tip_outlined,
                        size: screenWidth * 0.06,
                      ),
                      title: Text(
                        "Help Center",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.logout,color: Colors.red,
                        size: screenWidth * 0.06,
                      ),
                      title: Text(
                        "Log Out",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
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
        child: Container(
          height: screenWidth * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: screenWidth * 0.07,
                  color: selectedIndex2 == 0 ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                  onItemTapped2(0);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  size: screenWidth * 0.07,
                  color: selectedIndex2 == 1 ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen()),
                  );
                  onItemTapped2(1);
                },
              ),
              SizedBox(width: screenWidth * 0.15),
              IconButton(
                icon: Icon(
                  Icons.history,
                  size: screenWidth * 0.07,
                  color: selectedIndex2 == 3 ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()),
                  );
                  onItemTapped2(3);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: screenWidth * 0.07,
                  color: selectedIndex2 == 4 ? Colors.green : Colors.grey,
                ),
                onPressed:
                    () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      ),

                      onItemTapped2(4),
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
            MaterialPageRoute(builder: (context) => DeleteCartScreen()),
          );
          onItemTapped2(2);
        },
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
          size: screenWidth * 0.07,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
