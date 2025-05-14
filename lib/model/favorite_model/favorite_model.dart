import 'package:flutter/foundation.dart';

class FavoriteModel {
  final int itemsID;
  final int clientId;
  final String? title;
  final String? description;
  final String? price;
  final String? imagePath;
  final double? rating;

  FavoriteModel({
    required this.itemsID,
    required this.clientId,
    this.title,
    this.description,
    this.price,
    this.imagePath,
    this.rating,
  });

  // Factory constructor to create a FavoriteModel from JSON with improved error handling
  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    // Print keys for debugging if in debug mode
    if (kDebugMode) {
      print("JSON keys: ${json.keys.toList()}");
    }

    // Handle different possible key names
    final id = json['itemsID'] ?? json['itemId'] ?? json['id'] ?? 0;
    final cId = json['clientId'] ?? json['client_id'] ?? json['userId'] ?? 0;

    // Handle different data types for rating
    double? ratingValue;
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
          ratingValue = 0.0;
        }
      }
    }

    return FavoriteModel(
      itemsID: id is int ? id : int.tryParse(id.toString()) ?? 0,
      clientId: cId is int ? cId : int.tryParse(cId.toString()) ?? 0,
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      price: json['price']?.toString(),
      imagePath: json['imagePath'] ?? json['image'] ?? json['imageUrl'],
      rating: ratingValue ?? 0.0,
    );
  }

  // Convert a FavoriteModel to JSON
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

  // Convert FavoriteModel to FavoriteItem
  FavoriteItem toFavoriteItem() {
    return FavoriteItem(
      title: title ?? '',
      description: description ?? '',
      price: price ?? '',
      imagePath: imagePath ?? '',
      rating: rating ?? 0.0,
      itemId: itemsID,
    );
  }
}

// Keep the existing FavoriteItem class as it's used in the UI, but add itemId for removal
class FavoriteItem {
  final String title;
  final String description;
  final String price;
  final String imagePath;
  final double rating;
  final int itemId; // Added to track the API item ID

  FavoriteItem({
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.rating,
    this.itemId = -1, // Default value to avoid null issues
  });
}