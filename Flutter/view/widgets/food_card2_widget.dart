import 'package:flutter/material.dart';
import 'package:untitled/view/screen/remove_favourite_screen.dart';

class FoodCard2Widget extends StatefulWidget {
  final String title;
  final String description;
  final String price;
  final String imagePath;
  final double rating;
  final bool isRed;

  const FoodCard2Widget({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.rating,
    this.isRed = false,
  }) : super(key: key);

  @override
  _FoodCard2WidgetState createState() => _FoodCard2WidgetState();
}

class _FoodCard2WidgetState extends State<FoodCard2Widget> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double imageWidth = constraints.maxWidth * 0.6;
        double imageHeight = imageWidth * 0.6;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade300),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      widget.imagePath,
                      width: imageWidth,
                      height: imageHeight,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        if (widget.isRed) {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RemoveFavouritePage()),
                          );

                          if (result == true) {
                            setState(() {
                              isFavorited = false;
                            });
                          }
                        } else {
                          setState(() {
                            isFavorited = !isFavorited;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Icon(
                          isFavorited || widget.isRed
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.isRed ? Colors.red : (isFavorited ? Colors.red : Colors.green),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                child: Text(
                  "\$${widget.price}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                child: SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 0),
                    ),
                    child: Text(
                      "Order Now",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
