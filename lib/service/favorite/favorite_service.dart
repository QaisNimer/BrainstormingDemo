import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../core/const_values.dart';
import '../../model/favorite_model/favorite_model.dart';

class FavoriteService {
  final String baseUrl = ConstValue.baseUrl;

  // Get all favorites for a client
  Future<List<FavoriteModel>> getFavorites(int clientId) async {
    try {
      final url = '${baseUrl}Get-Favorites/$clientId';
      if (kDebugMode) {
        print("Calling API: $url");
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 15));

      if (kDebugMode) {
        print("API Response Status: ${response.statusCode}");
        final responseBody = response.body.length > 500
            ? '${response.body.substring(0, 500)}...'
            : response.body;
        print("API Response Body (preview): $responseBody");
      }

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          return [];
        }
        final dynamic decoded = json.decode(response.body);
        if (decoded is List) {
          return decoded.map((item) => FavoriteModel.fromJson(item)).toList();
        } else if (decoded is Map<String, dynamic>) {
          if (decoded.containsKey('data') && decoded['data'] is List) {
            return (decoded['data'] as List)
                .map((item) => FavoriteModel.fromJson(item))
                .toList();
          } else {
            return [FavoriteModel.fromJson(decoded)];
          }
        }
        return [];
      } else {
        throw Exception('API error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error getting favorites: $e");
      }
      throw Exception('Error getting favorites: $e');
    }
  }

  // Add an item to favorites
  Future<bool> addToFavorite(int itemId, int clientId) async {
    try {
      final url = '${baseUrl}Add-To-Favorite';
      if (kDebugMode) {
        print("Adding to favorites: $url");
        print("Item ID: $itemId, Client ID: $clientId");
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'itemsID': itemId,
          'clientId': clientId,
        }),
      ).timeout(const Duration(seconds: 10));

      if (kDebugMode) {
        print("Add to favorites response: ${response.statusCode}");
        print("Response body: ${response.body}");
      }

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      if (kDebugMode) {
        print("Error adding to favorites: $e");
      }
      throw Exception('Error adding to favorites: $e');
    }
  }

  // Remove an item from favorites
  Future<bool> removeFromFavorite(int itemId) async {
    try {
      final url = '${baseUrl}Remove-Item-From-Favorite/$itemId';
      if (kDebugMode) {
        print("Removing from favorites: $url");
      }

      final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (kDebugMode) {
        print("Remove from favorites response: ${response.statusCode}");
        print("Response body: ${response.body}");
      }

      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print("Error removing from favorites: $e");
      }
      throw Exception('Error removing from favorites: $e');
    }
  }

  // Debug function to help diagnose API issues
  Future<void> debugApiConnection() async {
    if (!kDebugMode) return;

    final clientId = 1; // Use test client ID

    try {
      print("===== API Connection Test =====");
      print("Base URL: $baseUrl");

      // Test a simple GET request to the API base
      try {
        final testResponse = await http.get(Uri.parse(baseUrl))
            .timeout(const Duration(seconds: 5));
        print("Base URL response: ${testResponse.statusCode}");
      } catch (e) {
        print("Base URL test failed: $e");
      }

      // Test the specific favorites endpoint
      try {
        final url = '${baseUrl}Get-Favorites/$clientId';
        print("Testing endpoint: $url");

        final response = await http.get(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
        ).timeout(const Duration(seconds: 10));

        print("Status code: ${response.statusCode}");
        print("Response length: ${response.body.length} characters");
        print("Response preview: ${response.body.length > 100 ? '${response.body.substring(0, 100)}...' : response.body}");
      } catch (e) {
        print("Endpoint test failed: $e");
      }

      print("===== Test Complete =====");
    } catch (e) {
      print("===== API Test Failed =====");
      print("Error: $e");
    }
  }
}
