class Top_Recommended_Model {
  int? id;
  String? englishName;
  String? arabicName;
  String? englishDescription;
  String? arabicDescription;
  double? price;
  Null? image;

  Top_Recommended_Model(
      {this.id,
        this.englishName,
        this.arabicName,
        this.englishDescription,
        this.arabicDescription,
        this.price,
        this.image});

  Top_Recommended_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    englishName = json['englishName'];
    arabicName = json['arabicName'];
    englishDescription = json['englishDescription'];
    arabicDescription = json['arabicDescription'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['englishName'] = this.englishName;
    data['arabicName'] = this.arabicName;
    data['englishDescription'] = this.englishDescription;
    data['arabicDescription'] = this.arabicDescription;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}