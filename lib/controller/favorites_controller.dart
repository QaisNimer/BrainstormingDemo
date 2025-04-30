import 'package:flutter/material.dart';

class FavoriteItem {
  final String title;
  final String description;
  final String price;
  final String imagePath;
  final double rating;

  FavoriteItem({
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.rating,
  });
}

class FavoritesController with ChangeNotifier {
  final List<FavoriteItem> _favorites = [];

  List<FavoriteItem> get favorites => _favorites;

  void add(FavoriteItem item) {
    _favorites.add(item);
    notifyListeners();
  }

  void remove(String title) {
    _favorites.removeWhere((element) => element.title == title);
    notifyListeners();
  }

  bool isFavorite(String title) {
    return _favorites.any((element) => element.title == title);
  }
}
