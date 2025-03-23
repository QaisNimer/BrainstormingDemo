import 'package:flutter/material.dart';
class CategoryButtonWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback? onPressed;


  const CategoryButtonWidget({
    required this.title,
    this.icon,
    this.isSelected = false,
    this.onPressed,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.green : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          side: BorderSide(
            color: Colors.green,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        onPressed:onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, size: 18),
            if (icon != null) SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}