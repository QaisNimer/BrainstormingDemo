class CategoryModel {
  final String arabicName;
  final String englishName;
  final String? imagePath;

  CategoryModel({
    required this.arabicName,
    required this.englishName,
    this.imagePath,
  });

  /// Factory method to create a CategoryModel from JSON data
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      arabicName: json['arabicName'] ?? 'N/A',
      englishName: json['englishName'] ?? 'N/A',
      imagePath: json['imagePath'] ?? '',
    );
  }

  /// Method to convert CategoryModel to JSON (useful for saving or sending data)
  Map<String, dynamic> toJson() {
    return {
      'arabicName': arabicName,
      'englishName': englishName,
      'imagePath': imagePath,
    };
  }
}
