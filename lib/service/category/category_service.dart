import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/const_values.dart';
import '../../model/category_model/category_model.dart';


class CategoryService {
  Future<List<CategoryModel>> getAllCategories() async {
    final response = await http.get(
      Uri.parse('${ConstValue.baseUrl}api/Category/Get-allCategories'),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
