import 'package:flutter/foundation.dart';

class FavoriteModel {
  final int itemsID;
  final int clientId;
  final String title;
  final String description;
  final String price;
  final String imagePath;
  final double rating;

  FavoriteModel({
    required this.itemsID,
    required this.clientId,
    this.title = '',
    this.description = '',
    this.price = '',
    this.imagePath = '',
    this.rating = 0.0,
  });

  // Factory constructor with improved error handling
  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print("Parsing JSON: ${json.toString().substring(0, json.toString().length > 100 ? 100 : json.toString().length)}...");
    }

    // Handle different possible key names for better API compatibility
    final id = json['itemsID'] ?? json['itemId'] ?? json['id'] ?? 0;
    final cId = json['clientId'] ?? json['client_id'] ?? json['userId'] ?? 0;

    // Handle different data types for rating
    double ratingValue = 0.0;
    if (json['rating'] != null) {
      if (json['rating'] is num) {
        ratingValue = (json['rating'] as num).toDouble();
      } else if (json['rating'] is String) {
        try {
          ratingValue = double.parse(json['rating']);
        } catch (e) {
          if (kDebugMode) {
            print("Could not parse rating string: ${json['rating']}");
          }
        }
      }
    }

    return FavoriteModel(
      itemsID: id is int ? id : int.tryParse(id.toString()) ?? 0,
      clientId: cId is int ? cId : int.tryParse(cId.toString()) ?? 0,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      imagePath: json['imagePath'] ?? json['image'] ?? json['imageUrl'] ?? '',
      rating: ratingValue,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemsID': itemsID,
      'clientId': clientId,
      'title': title,
      'description': description,
      'price': price,
      'imagePath': imagePath,
      'rating': rating,
    };
  }

  /// Convert to `FavoriteItem` for UI usage
  FavoriteItem toFavoriteItem() {
    return FavoriteItem(
      title: title,
      description: description,
      price: price,
      imagePath: imagePath,
      rating: rating,
      itemId: itemsID,
    );
  }
}

// Model used for UI and logical operations
class FavoriteItem {
  final String title;
  final String description;
  final String price;
  final String imagePath;
  final double rating;
  final int itemId;

  FavoriteItem({
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.rating,
    required this.itemId,
  });

  // Convert to JSON for storage or API calls
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imagePath': imagePath,
      'rating': rating,
      'itemId': itemId,
    };
  }

  // Create from JSON if needed
  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      imagePath: json['imagePath'] ?? json['image'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      itemId: json['itemId'] ?? 0,
    );
  }
}
