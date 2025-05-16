import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/const_values.dart';
import '../../model/category_model/category_model.dart';

class CategoryService {
  /// Fetches all categories from the API.
  Future<List<CategoryModel>> getAllCategories() async {
    final url = Uri.parse('${ConstValue.baseUrl}api/Category/Get-allCategories');
    try {
      final response = await http.get(
        url,
        headers: {'accept': '*/*'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        // Handling non-200 status codes
        throw Exception(
            'Failed to load categories. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Error handling for network or parsing errors
      throw Exception('Failed to load categories: ${e.toString()}');
    }
  }
}
