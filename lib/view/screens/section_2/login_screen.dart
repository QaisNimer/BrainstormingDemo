import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodtek/controller/login_controller.dart';
import 'package:foodtek/view/screens/section_2/rest_password_screen.dart';
import 'package:foodtek/view/screens/section_2/signup_screen.dart';
import 'package:foodtek/view/screens/section_3/home_screen.dart';
import 'package:provider/provider.dart';

import '../../../model/sign_model.dart';
import '../../../service/auth/authentication_service.dart';
import '../../widgets/input_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passTextEditingController = TextEditingController();
  bool rememberMe = false;

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
  }

  Future<void> _checkAutoLogin() async {
    String? remember = await secureStorage.read(key: 'rememberMe');
    String? userId = await secureStorage.read(key: 'userId');
    String? loginCountStr = await secureStorage.read(key: 'rememberLoginCount');
    int loginCount = int.tryParse(loginCountStr ?? '0') ?? 0;

    if (remember == 'true' && userId != null && loginCount < 2) {
      await secureStorage.write(key: 'rememberLoginCount', value: '${loginCount + 1}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  Future<void> _saveCredentials(String email, String userId) async {
    if (rememberMe) {
      await secureStorage.write(key: 'rememberMe', value: 'true');
      await secureStorage.write(key: 'userId', value: userId);
      await secureStorage.write(key: 'email', value: email);
      await secureStorage.write(key: 'rememberLoginCount', value: '0');
    } else {
      await secureStorage.delete(key: 'rememberMe');
      await secureStorage.delete(key: 'userId');
      await secureStorage.delete(key: 'email');
      await secureStorage.delete(key: 'rememberLoginCount');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = 140.0;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_photo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: topPadding, left: 20, right: 20, bottom: 12),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.login,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dont_have_an_account,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpScreen()),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.sign_up,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Consumer<LoginController>(
                        builder: (context, loginController, child) {
                          return InputWidget(
                            obscureText: false,
                            textEditingController: emailTextEditingController,
                            label: AppLocalizations.of(context)!.email,
                            hintText: "Loisbakit@gmail.com",
                            errorText: loginController.showErrorEmail
                                ? loginController.errorEmailMessage
                                : null,
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: passTextEditingController,
                        obscureText: loginController.obscureTextPassword,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: isDark ? Colors.grey[800] : Colors.white,
                          labelText: AppLocalizations.of(context)!.password,
                          labelStyle: TextStyle(color: isDark ? Colors.white : null),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => loginController.changeObscureTextPassword(),
                            icon: Icon(
                              loginController.obscureTextPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: isDark ? Colors.white : null,
                            ),
                          ),
                        ),
                        style: TextStyle(color: isDark ? Colors.white : Colors.black),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: Checkbox(
                                  value: rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      rememberMe = value!;
                                    });
                                  },
                                  activeColor: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context)!.remember_me,
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.forgot_password,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (emailTextEditingController.text.isEmpty || passTextEditingController.text.isEmpty) {
                            loginController.showCustomEmailError("Please enter both email and password");
                            return;
                          }

                          loginController.checkEmail(email: emailTextEditingController.text);
                          loginController.checkPassword(password: passTextEditingController.text);

                          Sign_Model signModel = Sign_Model(
                            email: emailTextEditingController.text,
                            password: passTextEditingController.text,
                          );

                          final authService = AuthenticationService();
                          bool success = await authService.login(signModel);

                          if (success) {
                            await _saveCredentials(emailTextEditingController.text, "user_id_123");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          } else {
                            loginController.showCustomEmailError("Login failed. Please check your credentials.");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(AppLocalizations.of(context)!.or, style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.g_mobiledata_rounded, color: Colors.red),
                        label: Text(
                          AppLocalizations.of(context)!.continue_with_google,
                          style: TextStyle(color: isDark ? Colors.white : Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? Colors.grey[850] : Colors.white,
                          minimumSize: Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.facebook, color: Colors.blue),
                        label: Text(
                          AppLocalizations.of(context)!.continue_with_facebook,
                          style: TextStyle(color: isDark ? Colors.white : Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? Colors.grey[850] : Colors.white,
                          minimumSize: Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.apple, color: Colors.black),
                        label: Text(
                          AppLocalizations.of(context)!.continue_with_apple,
                          style: TextStyle(color: isDark ? Colors.white : Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? Colors.grey[850] : Colors.white,
                          minimumSize: Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}