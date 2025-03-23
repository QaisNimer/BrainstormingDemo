import 'package:flutter/material.dart';

class FoodCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String imagePath;
  final double rating;

  const FoodCardWidget({
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 18),
              SizedBox(width: 3),
              Text(rating.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 5),
          Image.asset(imagePath, height: 70),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 3),
          Text(description, style: TextStyle(fontSize: 12, color: Colors.grey)),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$$price", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
