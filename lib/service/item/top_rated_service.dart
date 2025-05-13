import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/const_values.dart';
import '../../model/items/top_rated_model.dart';

Future<List<Top_Rated_Model>> fetchTopRatedItems() async {
  try {
    final response = await http.get(
      Uri.parse('${ConstValue.baseUrl}api/Items/top-rated-items'),
      headers: {"Content-Type": "application/json"},
    );

    print("📥 Status: ${response.statusCode}");
    print("📥 Body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Top_Rated_Model.fromJson(item)).toList();
    } else {
      print("❌ Failed to fetch: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("❗ Exception: $e");
    rethrow;
  }
}
