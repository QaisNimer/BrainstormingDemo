class CategoryModel {
  final String arabicName;
  final String englishName;
  final String? imagePath;

  CategoryModel({
    required this.arabicName,
    required this.englishName,
    this.imagePath,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      arabicName: json['arabicName'],
      englishName: json['englishName'],
      imagePath: json['imagePath'],
    );
  }
}