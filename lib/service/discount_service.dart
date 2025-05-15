import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/const_value.dart';
import '../model/discount_model.dart';

class DiscountService {
  Future<List<DiscountModel>> fetchDiscounts() async {

    final url = Uri.parse('${ConstValue.baseUrl}api/Discount/Get-allDiscounts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => DiscountModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load discounts');
    }
  }
}
