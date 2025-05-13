class Top_Rated_Model {
  int? id;
  String? englishName;
  String? arabicName;
  String? englishDescription;
  String? arabicDescription;
  int? price;
  String? image;
  int? rate;

  Top_Rated_Model({
    this.id,
    this.englishName,
    this.arabicName,
    this.englishDescription,
    this.arabicDescription,
    this.price,
    this.image,
    this.rate,
  });

  Top_Rated_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    englishName = json['englishName'];
    arabicName = json['arabicName'];
    englishDescription = json['englishDescription'];
    arabicDescription = json['arabicDescription'];

    price = (json['price'] is int)
        ? json['price']
        : (json['price'] is double)
        ? (json['price'] as double).toInt()
        : null;

    rate = (json['rate'] is int)
        ? json['rate']
        : (json['rate'] is double)
        ? (json['rate'] as double).toInt()
        : null;

    image = json['image']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['englishName'] = this.englishName;
    data['arabicName'] = this.arabicName;
    data['englishDescription'] = this.englishDescription;
    data['arabicDescription'] = this.arabicDescription;
    data['price'] = this.price;
    data['image'] = this.image;
    data['rate'] = this.rate;
    return data;
  }
}
