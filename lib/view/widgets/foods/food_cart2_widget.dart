import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../controller/favorites_controller.dart';
import '../../../model/favorite_model/favorite_model.dart';
import '../../screens/section_3/remove_favourite_screen.dart';

class FoodCard2Widget extends StatefulWidget {
  final String title;
  final String description;
  final String price;
  final String imagePath;
  final double rating;
  final bool isRed;
  final int itemId; // Made this required, not optional

  const FoodCard2Widget({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.rating,
    this.isRed = false,
    required this.itemId, // Required parameter
  });

  @override
  _FoodCard2WidgetState createState() => _FoodCard2WidgetState();
}

class _FoodCard2WidgetState extends State<FoodCard2Widget> {
  late bool isFavorited;

  @override
  void initState() {
    super.initState();
    final favoritesController = Provider.of<FavoritesController>(
      context,
      listen: false,
    );
    isFavorited = favoritesController.isFavorite(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    final favoritesController = Provider.of<FavoritesController>(
      context,
      listen: false,
    );

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
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback to network image if asset fails
                        return Image.network(
                          widget.imagePath,
                          width: imageWidth,
                          height: imageHeight,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            // If both fail, show placeholder
                            return Container(
                              width: imageWidth,
                              height: imageHeight,
                              color: Colors.grey[300],
                              child: Icon(Icons.image_not_supported),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        if (widget.isRed) {
                          // For favorites screen - set current item and navigate to confirmation page
                          final favoriteItem = FavoriteItem(
                            title: widget.title,
                            description: widget.description,
                            price: widget.price,
                            imagePath: widget.imagePath,
                            rating: widget.rating,
                            itemId: widget.itemId,
                          );

                          favoritesController.setCurrentItem(favoriteItem);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RemoveFavouritePage(),
                            ),
                          );
                        } else {
                          // For regular screens - toggle favorite status directly
                          setState(() {
                            isFavorited = !isFavorited;
                          });

                          final item = FavoriteItem(
                            title: widget.title,
                            description: widget.description,
                            price: widget.price,
                            imagePath: widget.imagePath,
                            rating: widget.rating,
                            itemId: widget.itemId,
                          );

                          bool success;
                          if (isFavorited) {
                            // Add to favorites
                            success = await favoritesController.add(item, widget.itemId);
                            if (!success) {
                              // Revert UI state if operation failed
                              setState(() {
                                isFavorited = false;
                              });
                            }
                          } else {
                            // Remove from favorites
                            success = await favoritesController.remove(widget.title, widget.itemId);
                            if (!success) {
                              // Revert UI state if operation failed
                              setState(() {
                                isFavorited = true;
                              });
                            }
                          }
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
                          (widget.isRed || isFavorited)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                          (widget.isRed || isFavorited)
                              ? Colors.red
                              : Colors.green,
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
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 2,
                ),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 2,
                ),
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
                      AppLocalizations.of(context)!.order_now,
                      style: TextStyle(fontSize: 12, color: Colors.white),
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