import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/const_values.dart';
import '../../model/favorite_model/favorite_model.dart';

class FavoriteService {
  final String baseUrl = ConstValue.baseUrl;

  // Get all favorites for a client
  Future<List<FavoriteModel>> getFavorites(int clientId) async {
    try {
      print("Calling API: ${baseUrl}Get-Favorites/$clientId");
      final response = await http.get(
        Uri.parse('${baseUrl}Get-Favorites/$clientId'),
        headers: {'Content-Type': 'application/json'},
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => FavoriteModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load favorites: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print("Exception in getFavorites: $e");
      throw Exception('Error getting favorites: $e');
    }
  }

  // Add an item to favorites
  Future<bool> addToFavorite(int itemsID, int clientId) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}Add-To-Favorite'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'itemsID': itemsID,
          'clientId': clientId,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error adding to favorites: $e');
    }
  }

  // Remove an item from favorites
  Future<bool> removeFromFavorite(int itemId) async {
    try {
      final response = await http.delete(
        Uri.parse('${baseUrl}Remove-Item-From-Favorite/$itemId'),
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error removing from favorites: $e');
    }
  }
}