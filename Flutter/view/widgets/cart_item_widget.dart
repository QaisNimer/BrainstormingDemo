import 'package:flutter/material.dart';

class CartItemWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final int price;
  final String image;
  final VoidCallback onDelete;

  const CartItemWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.image,
    required this.onDelete,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(
        '${widget.title}_${widget.price}_${DateTime.now().millisecondsSinceEpoch}',
      ),
      direction: DismissDirection.endToStart,
      background: Container(
        margin:  EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(7),
        ),
        alignment: Alignment.centerRight,
        padding:  EdgeInsets.only(right: 20),
        child:  Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) => widget.onDelete(),
      confirmDismiss: (direction) async {
        return true;
      },
      child: Container(
        margin:  EdgeInsets.symmetric(vertical: 7),
        padding:  EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.image,
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
                    widget.title,
                    style:  TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                   SizedBox(height: 4),
                  Text(
                    "\$${widget.price}",
                    style:  TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.green, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon:  Icon(
                      Icons.remove,
                      size: 18,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                    padding: EdgeInsets.zero,
                  ),
                ),
                 SizedBox(width: 10),
                SizedBox(
                  width: 20,
                  child: Text(
                    quantity.toString(),
                    textAlign: TextAlign.center,
                    style:  TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                 SizedBox(width: 10),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.green, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon:  Icon(Icons.add, size: 18, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
