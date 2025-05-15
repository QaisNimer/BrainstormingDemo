import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/const_values.dart';
import '../model/cart_model.dart';

class CartService {
  final String baseUrl = ConstValue.baseUrl;

  /// جلب كل عناصر السلة
  Future<List<CartModel>> fetchCartItems() async {
    final response = await http.get(Uri.parse('${baseUrl}api/Cart/GetAll'));

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CartModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  Future<bool> addCartItem(CartModel model) async {
    final response = await http.post(
      Uri.parse('${baseUrl}api/Cart/add-item'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );

    return response.statusCode == 200;
  }

  Future<bool> updateCartItem(CartModel model) async {
    final response = await http.put(
      Uri.parse('${baseUrl}api/Cart/Update/${model.cartItemID}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteCartItem(int cartItemID) async {
    final response = await http.delete(
      Uri.parse('${baseUrl}api/Cart/Delete/$cartItemID'),
    );

    return response.statusCode == 200;
  }
}
