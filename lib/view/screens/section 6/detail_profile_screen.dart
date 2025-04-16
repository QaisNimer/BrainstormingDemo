import 'package:flutter/material.dart';
import 'package:foodtek/view/screens/section%204/delete_cart_screen.dart';
import 'package:foodtek/view/screens/section%203/favorites_screen.dart';
import 'package:foodtek/view/screens/section%204/history_screen.dart';
import 'package:foodtek/view/screens/section%203/home_screen.dart';
import 'package:foodtek/view/screens/section%206/profile_screen.dart';
import 'package:foodtek/view/screens/section%206/track_location_screen.dart';
import 'package:provider/provider.dart';
import '../../../controller/profile_controller.dart';
import '../../widgets/bottom_nav_Item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailProfileScreen extends StatefulWidget {
  int selectedIndex = 0;

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
    final profileController = Provider.of<ProfileController>(context, listen: false);
    _usernameController = TextEditingController(text: profileController.username);
    _emailController = TextEditingController(text: profileController.email);
    _phoneController = TextEditingController(text: profileController.phoneNumber);
    _passwordController = TextEditingController(text: profileController.password);
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(" Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage("assets/images/profile.png"),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(profileController.username,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Center(
              child: Text(profileController.email,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildTextField("Username", _usernameController, (val) => profileController.updateUsername(val)),
                    _buildTextField("Email", _emailController, (val) => profileController.updateEmail(val)),
                    _buildTextField("Phone Number", _phoneController, (val) => profileController.updatePhoneNumber(val)),
                    _buildTextField("Password", _passwordController, (val) => profileController.updatePassword(val), isPassword: true),
                    _buildTextField("Address", _addressController, (val) => profileController.updateAddress(val)),
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
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text("Update", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
              ),
              BottomNavItemWidget(
                icon: Icons.favorite,
                label: AppLocalizations.of(context)!.favorite,
                isSelected: widget.selectedIndex == 1,
                onTap: () {
                  onItemTapped(1);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const FavoritesScreen()));
                },
              ),
              const SizedBox(width: 40),
              BottomNavItemWidget(
                icon: Icons.home_work,
                label: AppLocalizations.of(context)!.track,
                isSelected: widget.selectedIndex == 3,
                onTap: () {
                  onItemTapped(3);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TrackLocationScreen()));
                },
              ),
              BottomNavItemWidget(
                icon: Icons.person,
                label: AppLocalizations.of(context)!.profile,
                isSelected: widget.selectedIndex == 4,
                onTap: () {
                  onItemTapped(4);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
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
              MaterialPageRoute(builder: (context) => const DeleteCartScreen()));
        },
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, Function(String) onChanged, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }
}