import 'package:flutter/material.dart';
import '../detail_cart_row_widget.dart';

class CartTotalWidget extends StatelessWidget {
  final double subtotal;
  final double delivery;
  final double discount;
  final VoidCallback onOrderPressed;

  const CartTotalWidget({
    super.key,
    required this.subtotal,
    required this.delivery,
    required this.discount,
    required this.onOrderPressed,
  });

  @override
  Widget build(BuildContext context) {
    final total = subtotal + delivery - discount;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/card.total.png"),
          fit: BoxFit.cover,
        ),
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green, width: 1.5),
      ),
      child: Column(
        children: [
          DetailCartRow(
            label: "Sub-total",
            value: "\$${subtotal.toStringAsFixed(2)}",
            labelColor: textColor,
            valueColor: textColor,
          ),
          const SizedBox(height: 8),
          DetailCartRow(
            label: "Delivery",
            value: "\$${delivery.toStringAsFixed(2)}",
            labelColor: textColor,
            valueColor: textColor,
          ),
          const SizedBox(height: 8),
          DetailCartRow(
            label: "Discount",
            value: "\$${discount.toStringAsFixed(2)}",
            labelColor: textColor,
            valueColor: textColor,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: DetailCartRow(
              label: "TOTAL",
              value: "\$${total.toStringAsFixed(2)}",
              isTotal: true,
              labelColor: textColor,
              valueColor: textColor,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? Colors.green[400] : Colors.white,
                foregroundColor: isDark ? Colors.black : Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
              onPressed: onOrderPressed,
              child: const Text(
                "Place My Order",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
