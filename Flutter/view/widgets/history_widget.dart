import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final int price;
  final String image;
  final DateTime date;

  //final IconData? icon;

  const HistoryWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.image,
    required this.date,
    //   this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) =>
                      Icon(Icons.fastfood, size: 60),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                Text(
                  "\$$price",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    size: 17,
                    color: Colors.green,
                  ),
                  SizedBox(width: 3),
                  Text(
                    DateFormat('MM.dd.yyyy').format(date),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.autorenew, size: 17, color: Colors.green),

                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Reorder",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
