import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/signup_controller.dart';
import '../../../model/auth_model/signup_model.dart';
import '../../widgets/signup_widgets.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  String? _backendFormattedDate;

  Future<void> _registerUser(BuildContext context) async {
    // Check for empty fields
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _dateController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      _showErrorDialog(context, 'Please fill in all required fields');
      return;
    }

    final signUpController = Provider.of<SignUpController>(
      context,
      listen: false,
    );
    final SignUpModel user = SignUpModel(
      email: _emailController.text,
      password: _passwordController.text,
      phonenum: _phoneController.text,
      firstname: _firstNameController.text,
      lastname: _lastNameController.text,
      birthDate: _backendFormattedDate, // Already in ISO format
    );

    log('Sending user data with birthDate: ${user.birthDate}');
    final success = await signUpController.registerUser(user);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), //  LoginScreen
      );
    } else {
      _showErrorDialog(context, signUpController.errorMessage);
    }
  }


  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final signUpController = Provider.of<SignUpController>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login_photo.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80),
                const SizedBox(height: 100),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.sign_up,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(
                              context,
                            )!.already_have_an_account,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _firstNameController,
                              labelText:
                              AppLocalizations.of(context)!.first_name,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              controller: _lastNameController,
                              labelText:
                              AppLocalizations.of(context)!.last_name,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _emailController,
                        labelText: AppLocalizations.of(context)!.email,
                        keyboardType: TextInputType.emailAddress,
                        suffixIcon: const Icon(Icons.email),
                      ),
                      CustomTextField(
                        controller: _dateController,
                        labelText: AppLocalizations.of(context)!.birth_date,
                        readOnly: true,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              // Format date in the exact format required by the API
                              final formattedDate = DateFormat(
                                "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
                              ).format(pickedDate.toUtc());

                              log('Selected date formatted: $formattedDate');

                              setState(() {
                                // Display a user-friendly format in the UI
                                _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);

                                // Store the ISO format for API
                                _backendFormattedDate = formattedDate;
                              });
                            }
                          },
                        ),
                      ),
                      PhoneInputField(controller: _phoneController),
                      CustomTextField(
                        controller: _passwordController,
                        labelText: AppLocalizations.of(context)!.set_password,
                        isPassword: !_isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      signUpController.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () => _registerUser(context),
                        child: Text(
                          AppLocalizations.of(context)!.register,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}