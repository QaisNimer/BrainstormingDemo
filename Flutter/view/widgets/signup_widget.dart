import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneInputField({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: IntlPhoneField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
            initialCountryCode: 'JO',
            onChanged: (phone) {
              print(phone.completeNumber);
            },
            ),
        );
    }
}
