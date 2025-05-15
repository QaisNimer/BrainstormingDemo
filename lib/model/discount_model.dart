class DiscountModel {
  final int id;
  final String titleEnglish;
  final String? image;

  DiscountModel({
    required this.id,
    required this.titleEnglish,
    this.image,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      id: json['id'],
      titleEnglish: json['titleEnglish'] ?? '',
      image: json['image'],
    );
  }
}
