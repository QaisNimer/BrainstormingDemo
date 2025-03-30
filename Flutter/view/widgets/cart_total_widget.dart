import 'package:flutter/material.dart';
import 'detail_cart_row_widget.dart';

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

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/card.total.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green, width: 1.5),
      ),
      child: Column(
        children: [
          DetailCartRow(
            label: "Sub-total",
            value: "\$${subtotal.toStringAsFixed(2)}",
          ),
          SizedBox(height: 8),
          DetailCartRow(
            label: "Delivery",
            value: "\$${delivery.toStringAsFixed(2)}",
          ),
          SizedBox(height: 8),
          DetailCartRow(
            label: "Discount",
            value: "\$${discount.toStringAsFixed(2)}",
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: DetailCartRow(
              label: "TOTAL",
              value: "\$${total.toStringAsFixed(2)}",
              isTotal: true,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
              onPressed: onOrderPressed,
              child: Text(
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
