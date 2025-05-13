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

  // Factory constructor to create a FavoriteModel from JSON
  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      itemsID: json['itemsID'] ?? 0,
      clientId: json['clientId'] ?? 0,
      title: json['title'],
      description: json['description'],
      price: json['price'],
      imagePath: json['imagePath'],
      rating: json['rating'] != null ? json['rating'].toDouble() : 0.0,
    );
  }

  // Convert a FavoriteModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'itemsID': itemsID,
      'clientId': clientId,
      // Include other fields only if they are meant to be sent to the API
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
    );
  }
}

// Keep the existing FavoriteItem class as it's used in the UI
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