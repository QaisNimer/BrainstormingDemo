import 'package:flutter/material.dart';

class DeliveryProgressIndicatorWidget extends StatelessWidget {
  final int currentStep;

  const DeliveryProgressIndicatorWidget({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildStep("Order Placed", 0),
            buildStep("On The Way", 1),
            buildStep("Delivered", 2),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 5,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: currentStep >= 0 ? Colors.green : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 5,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(

                  color:
                      currentStep >= 1
                          ? Colors.green.withOpacity(0.5)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 5,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color:
                      currentStep >= 2
                          ? Colors.green.withOpacity(0.5)
                          : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStep(String text, int step) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight:
                currentStep == step ? FontWeight.bold : FontWeight.normal,
            color: currentStep >= step ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }
}
