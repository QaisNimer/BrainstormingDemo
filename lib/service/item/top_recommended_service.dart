import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/const_values.dart';
import '../../model/items/top_recommended_model.dart';


class TopRecommendedService {
  final String _endpoint = "${ConstValue.baseUrl}api/Items/top-recommended-items";

  Future<List<Top_Recommended_Model>> fetchTopRecommendedItems() async {
    try {
      final response = await http.get(Uri.parse(_endpoint));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Top_Recommended_Model.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load recommended items');
      }
    } catch (e) {
      print("Error fetching top recommended items: $e");
      return [];
    }
  }
}
