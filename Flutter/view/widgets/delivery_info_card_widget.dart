import 'package:flutter/material.dart';

class DeliveryProgressIndicatorWidget extends StatelessWidget {
  final int currentStep;

  const DeliveryProgressIndicatorWidget({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStep("Order Placed", 0),
            _buildStep("On The Way", 1),
            _buildStep("Delivered", 2),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildLine(0),
            _buildLine(1),
            _buildLine(2),
          ],
        ),
      ],
    );
  }

  Widget _buildStep(String text, int step) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: currentStep == step ? FontWeight.bold : FontWeight.normal,
        color: currentStep >= step ? Colors.green : Colors.grey,
      ),
    );
  }

  Widget _buildLine(int step) {
    Color color = Colors.transparent;
    if (currentStep >= step) {
      if (step == 0) {
        color = Colors.green;
      } else if (step == 1) {
        color = Colors.green.withOpacity(0.5);
      } else {
        color = Colors.black;
      }
    }

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        height: 3,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}