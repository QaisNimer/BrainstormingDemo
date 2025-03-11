import 'package:flutter/material.dart';
import 'package:foodtek/controller/login_controller.dart';
import 'package:foodtek/view/screens/forgot_password_page.dart';
import 'package:foodtek/view/screens/home_screen.dart';
import 'package:foodtek/view/screens/intro_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/input_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passTextEditingController =
      TextEditingController();
  bool RememberMe = false;

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
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.69,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                  ),
                  SizedBox(height: 2),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => IntroScreen()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        children: [
                          TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 6),

                  Consumer<LoginController>(
                    builder: (context, loginController, child) {
                      return InputWidget(
                        obscureText: false,
                        textEditingController: emailTextEditingController,
                        label: "Email",
                        hintText: "Loisbakit@gmail.com",
                        errorText:
                            loginController.showErrorEmail
                                ? "Enter a valid Email"
                                : null,
                      );
                    },
                  ),

                  SizedBox(height: 15),

                  TextFormField(
                    controller: passTextEditingController,
                    obscureText: loginController.obscureTextPassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // errorText:
                      //     loginController.showErrorPassword
                      //         ? "Enter Your Password"
                      //         : null,
                      suffixIcon: IconButton(
                        onPressed: () {
                          loginController.changeObscureTextPassword();
                        },
                        icon: Icon(
                          loginController.obscureTextPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: RememberMe,
                            onChanged: (value) {
                              setState(() {
                                RememberMe = value!;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                          Text("Remember me"),
                        ],
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 7),

                  TextButton(
                    onPressed: () {
                      loginController.checkEmail(
                        email: emailTextEditingController.text,
                      );
                      loginController.checkPassword(
                        password: passTextEditingController.text,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: 130,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "or",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),

                  SizedBox(height: 6),

                  ElevatedButton.icon(
                    onPressed: () {
                      //add gmail here
                    },
                    icon: Icon(Icons.g_mobiledata_outlined, color: Colors.red),
                    label: Text(
                      "Continue with Gmail",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: 6),

                  ElevatedButton.icon(
                    onPressed: () {
                      //add facebook here
                    },
                    icon: Icon(Icons.facebook, color: Colors.blue),
                    label: Text(
                      "Continue with Facebook",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 23,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: 6),

                  ElevatedButton.icon(
                    onPressed: () {
                      //add the apple here
                    },
                    icon: Icon(Icons.apple, color: Colors.black),
                    label: Text(
                      "Continue with Apple",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 34,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.white),
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
