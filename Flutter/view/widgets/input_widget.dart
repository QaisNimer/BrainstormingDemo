import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  TextEditingController textEditingController;
  String label;
  bool obscureText;
  String? errorText;
  String? hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;

  InputWidget({
    super.key,
    required this.textEditingController,
    required this.obscureText,
    this.prefixIcon,
    required this.label,
    this.suffixIcon,
    this.hintText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: textEditingController,
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        errorText: errorText,
      ),
    );
  }
}

//رمز البلد
//things of signUp