import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/view/screen/congra_screen.dart';
import 'package:untitled/view/screen/login_screen.dart';

import '../../controller/login_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController newPassTextEditingController =
  TextEditingController();
  final TextEditingController confirmPassTextEditingController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login_photo.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              width: MediaQuery.of(context).size.width * 0.70,
              height: MediaQuery.of(context).size.height * 0.43,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_back_sharp),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Text(
                        "Want to try with my current password?",
                        style: TextStyle(fontSize: 10),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  TextFormField(
                    controller: newPassTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      label: Text("New Password"),
                      fillColor: Colors.white,
                      //  labelText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),

                      // errorText:
                      // loginController.showErrorPassword
                      //     ? "Enter Your Password"
                      //     : null,
                    ),
                  ),
                  SizedBox(height: 10),

                  TextFormField(
                    controller: confirmPassTextEditingController,
                    //put in login controller
                    obscureText: loginController.obscureTextPassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Confirm New Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),

                      // errorText:
                      // loginController.showErrorPassword
                      //     ? "Enter Your Password"
                      //     : null,
                    ),
                  ),
                  SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      loginController.checkPassword(
                        password:
                        newPassTextEditingController
                            .text, //put in login controller
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CongraScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 9,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Update Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}