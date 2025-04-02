import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/controller/profile_controller.dart';

class DetailProfileScreen extends StatefulWidget {
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
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
            SizedBox(height: 10),
            Center(
              child: Text(profileController.username,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Center(
              child: Text(profileController.email,
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
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
                    _buildTextField("Username", _usernameController, (val) => profileController.updateUsername(val)),
                    _buildTextField("Email", _emailController, (val) => profileController.updateEmail(val)),
                    _buildTextField("Phone Number", _phoneController, (val) => profileController.updatePhoneNumber(val)),
                    _buildTextField("Password", _passwordController, (val) => profileController.updatePassword(val), isPassword: true),
                    _buildTextField("Address", _addressController, (val) => profileController.updateAddress(val)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text("Update", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.grey),
              onPressed: () {},
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(Icons.history, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.grey),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: Icon(Icons.shopping_cart, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, Function(String) onChanged, {bool isPassword = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
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
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }
}
