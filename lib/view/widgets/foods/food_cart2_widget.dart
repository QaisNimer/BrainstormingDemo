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
  final int itemId; // Required

  const FoodCard2Widget({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.rating,
    this.isRed = false,
    required this.itemId,
  });

  @override
  _FoodCard2WidgetState createState() => _FoodCard2WidgetState();
}

class _FoodCard2WidgetState extends State<FoodCard2Widget> {
  late bool isFavorited;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final favoritesController = Provider.of<FavoritesController>(
      context,
      listen: false,
    );
    isFavorited = favoritesController.isFavorite(widget.itemId);
  }

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      widget.imagePath,
                      width: imageWidth,
                      height: imageHeight,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: imageWidth,
                          height: imageHeight,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: isLoading ? null : () => handleFavoriteTap(),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Icon(
                          (widget.isRed || isFavorited)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: (widget.isRed || isFavorited)
                              ? Colors.red
                              : Colors.grey,
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "\$${widget.price}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.order_now,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
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

  void handleFavoriteTap() async {
    final favoritesController =
    Provider.of<FavoritesController>(context, listen: false);

    if (widget.isRed) {
      favoritesController.setCurrentItem(
        FavoriteItem(
          title: widget.title,
          description: widget.description,
          price: widget.price,
          imagePath: widget.imagePath,
          rating: widget.rating,
          itemId: widget.itemId,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RemoveFavouritePage(),
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    final favoriteItem = FavoriteItem(
      title: widget.title,
      description: widget.description,
      price: widget.price,
      imagePath: widget.imagePath,
      rating: widget.rating,
      itemId: widget.itemId,
    );

    final success = isFavorited
        ? await favoritesController.remove(widget.itemId)
        : await favoritesController.add(favoriteItem);

    if (success) {
      setState(() {
        isFavorited = !isFavorited;
      });
    }

    setState(() => isLoading = false);
  }
}
