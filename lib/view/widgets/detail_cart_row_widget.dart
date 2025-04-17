import 'package:flutter/material.dart';

class DetailCartRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  final Color? labelColor;
  final Color? valueColor;

  const DetailCartRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
    this.labelColor,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 19 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: labelColor ?? defaultColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 19 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: valueColor ?? defaultColor,
          ),
        ),
      ],
    );
  }
}
