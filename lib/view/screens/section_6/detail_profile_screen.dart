import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodtek/view/screens/section_3/favorites_screen.dart';
import 'package:foodtek/view/screens/section_3/home_screen.dart';
import 'package:foodtek/view/screens/section_4/delete_cart_screen.dart';
import 'package:foodtek/view/screens/section_6/profile_screen.dart';
import 'package:foodtek/view/screens/section_6/track_location_screen.dart';
import 'package:provider/provider.dart';

import '../../../controller/profile_controller.dart';
import '../../widgets/bottom_nav_Item_widget.dart';

class DetailProfileScreen extends StatefulWidget {
  int selectedIndex = 0;

  DetailProfileScreen({super.key});

  @override
  _DetailProfileScreenState createState() => _DetailProfileScreenState();
}

class _DetailProfileScreenState extends State<DetailProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    final profileController = Provider.of<ProfileController>(
      context,
      listen: false,
    );
    _usernameController = TextEditingController(
      text: profileController.username,
    );
    _emailController = TextEditingController(text: profileController.email);
    _phoneController = TextEditingController(
      text: profileController.phoneNumber,
    );
    _passwordController = TextEditingController(
      text: profileController.password,
    );
    _addressController = TextEditingController(text: profileController.address);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/profile.png"),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                profileController.username,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            Center(
              child: Text(
                profileController.email,
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode ? Colors.white70 : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[850] : Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color:
                        isDarkMode
                            ? Colors.white30
                            : Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildTextField(
                      AppLocalizations.of(context)!.user_name,
                      _usernameController,
                      (val) => profileController.updateUsername(val),
                      isDarkMode: isDarkMode,
                    ),
                    _buildTextField(
                      AppLocalizations.of(context)!.email,
                      _emailController,
                      (val) => profileController.updateEmail(val),
                      isDarkMode: isDarkMode,
                    ),
                    _buildTextField(
                      AppLocalizations.of(context)!.phone_number,
                      _phoneController,
                      (val) => profileController.updatePhoneNumber(val),
                      isDarkMode: isDarkMode,
                    ),
                    _buildTextField(
                      AppLocalizations.of(context)!.password,
                      _passwordController,
                      (val) => profileController.updatePassword(val),
                      isPassword: true,
                      isDarkMode: isDarkMode,
                    ),
                    _buildTextField(
                      AppLocalizations.of(context)!.address,
                      _addressController,
                      (val) => profileController.updateAddress(val),
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  AppLocalizations.of(context)!.update,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: isDarkMode ? Colors.black : Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavItemWidget(
                icon: Icons.home,
                label: AppLocalizations.of(context)!.home,
                isSelected: widget.selectedIndex == 0,
                onTap: () {
                  onItemTapped(0);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
              ),
              BottomNavItemWidget(
                icon: Icons.favorite,
                label: AppLocalizations.of(context)!.favorite,
                isSelected: widget.selectedIndex == 1,
                onTap: () {
                  onItemTapped(1);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                  );
                },
              ),
              const SizedBox(width: 40),
              BottomNavItemWidget(
                icon: Icons.home_work,
                label: AppLocalizations.of(context)!.track,
                isSelected: widget.selectedIndex == 3,
                onTap: () {
                  onItemTapped(3);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TrackLocationScreen(),
                    ),
                  );
                },
              ),
              BottomNavItemWidget(
                icon: Icons.person,
                label: AppLocalizations.of(context)!.profile,
                isSelected: widget.selectedIndex == 4,
                onTap: () {
                  onItemTapped(4);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
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
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    Function(String) onChanged, {
    bool isPassword = false,
    bool isDarkMode = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.white70 : Colors.grey,
              width: 1,
            ),
          ),
        ),
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }
}
