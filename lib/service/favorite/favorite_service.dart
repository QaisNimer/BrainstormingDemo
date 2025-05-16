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
      if (clientId <= 0) {
        throw Exception('Client ID must be greater than zero');
      }

      final url = '${baseUrl}Get-Favorites/$clientId';
      if (kDebugMode) print("Fetching favorites from: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 15));

      if (kDebugMode) {
        print("API Response Status: ${response.statusCode}");
        print("API Response Body (preview): ${response.body.length > 500 ? '${response.body.substring(0, 500)}...' : response.body}");
      }

      if (response.statusCode == 200) {
        if (response.body.isEmpty) return [];

        final decoded = json.decode(response.body);
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
      }

      throw Exception('API error ${response.statusCode}: ${response.reasonPhrase}');
    } catch (e) {
      if (kDebugMode) print("Error getting favorites: $e");
      throw Exception('Error getting favorites: $e');
    }
  }

  // Add an item to favorites
  Future<bool> addToFavorite(int itemId, int clientId) async {
    try {
      if (itemId <= 0 || clientId <= 0) {
        throw Exception('Both itemId and clientId must be greater than zero');
      }

      final url = '${baseUrl}Add-To-Favorite';
      final payload = json.encode({
        'itemsID': itemId,
        'clientId': clientId,
      });

      if (kDebugMode) {
        print("Adding to favorites: $url");
        print("Payload: $payload");
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: payload,
      ).timeout(const Duration(seconds: 15));

      if (kDebugMode) {
        print("Add to favorites response: ${response.statusCode}");
        print("Response body: ${response.body}");
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('API error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      if (kDebugMode) print("Error adding to favorites: $e");
      throw Exception('Error adding to favorites: $e');
    }
  }

  // Remove from favorites with response body check
  Future<bool> removeFromFavorite(int itemId) async {
    try {
      if (itemId <= 0) {
        throw Exception('Item ID must be greater than zero');
      }

      final url = '${baseUrl}Remove-Item-From-Favorite/$itemId';
      if (kDebugMode) print("Removing from favorites: $url");

      final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (kDebugMode) {
        print("Remove response: ${response.statusCode}");
        print("Response body: ${response.body}");
      }

      if (response.statusCode == 200) {
        if (response.body.contains("does not exist")) {
          if (kDebugMode) print("Item does not exist in favorites.");
          return true; // Already removed
        }
        return true;
      }

      throw Exception('API error ${response.statusCode}: ${response.body}');
    } catch (e) {
      if (kDebugMode) print("Error removing from favorites: $e");
      throw Exception('Error removing from favorites: $e');
    }
  }

  // Debug function to help diagnose API issues
  Future<void> debugApiConnection() async {
    if (!kDebugMode) return;

    final clientId = 1;
    final testItemId = 1;

    print("===== API Connection Test =====");
    print("Base URL: $baseUrl");

    await _testApiConnection();
    await _testGetFavorites(clientId);
    await _testAddToFavorites(testItemId, clientId);
    await _testRemoveFromFavorites(testItemId);

    print("===== Test Complete =====");
  }

  // Test base URL connection
  Future<void> _testApiConnection() async {
    try {
      final testResponse = await http.get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 5));
      print("Base URL response: ${testResponse.statusCode}");
    } catch (e) {
      print("Base URL test failed: $e");
    }
  }

  // Test Get-Favorites endpoint
  Future<void> _testGetFavorites(int clientId) async {
    try {
      final url = '${baseUrl}Get-Favorites/$clientId';
      print("Testing GET: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      print("GET Status: ${response.statusCode}");
      print("Response preview: ${response.body.length > 100 ? '${response.body.substring(0, 100)}...' : response.body}");
    } catch (e) {
      print("GET test failed: $e");
    }
  }

  // Test Add-To-Favorite endpoint
  Future<void> _testAddToFavorites(int itemId, int clientId) async {
    try {
      final url = '${baseUrl}Add-To-Favorite';
      print("Testing POST: $url");

      final payload = json.encode({'itemsID': itemId, 'clientId': clientId});
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: payload,
      ).timeout(const Duration(seconds: 10));

      print("POST Status: ${response.statusCode}");
      print("Response: ${response.body}");
    } catch (e) {
      print("POST test failed: $e");
    }
  }

  // Test Remove-Item-From-Favorite endpoint
  Future<void> _testRemoveFromFavorites(int itemId) async {
    try {
      final url = '${baseUrl}Remove-Item-From-Favorite/$itemId';
      print("Testing DELETE: $url");

      final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      print("DELETE Status: ${response.statusCode}");
      print("Response: ${response.body}");
    } catch (e) {
      print("DELETE test failed: $e");
    }
  }
}
