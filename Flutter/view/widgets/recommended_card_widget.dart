import 'package:flutter/material.dart';

class RecommendedCardWidget extends StatelessWidget {
  final String imagePath;
  final String price;

  const RecommendedCardWidget({
    required this.imagePath,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5)),
          child: Text(price, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),

        ),
      ),
    );
  }
}
