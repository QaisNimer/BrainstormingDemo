class CartModel {
  int? cartId;
  int? itemId;
  int? quantity;
  int? totalPrice;
  String? note;
  int? cartItemID;

  CartModel(
      {this.cartId,
        this.itemId,
        this.quantity,
        this.totalPrice,
        this.note,
        this.cartItemID});

  CartModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    itemId = json['itemId'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
    note = json['note'];
    cartItemID = json['cartItemID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    data['itemId'] = this.itemId;
    data['quantity'] = this.quantity;
    data['totalPrice'] = this.totalPrice;
    data['note'] = this.note;
    data['cartItemID'] = this.cartItemID;
    return data;
  }
}