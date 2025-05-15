import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/notification_model.dart';
import '../core/const_values.dart';

class NotificationService {
  final String baseUrl = ConstValue.baseUrl.replaceAll(RegExp(r'/+$'), '');

  // Fetch all notifications for a user
  Future<List<NotificationModel>> fetchNotifications(int userId) async {
    final uri = Uri.parse('$baseUrl/api/Notification/notifications?userId=$userId');
    print("🔍 Fetching from: $uri");

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer YOUR_TOKEN', // Uncomment if needed
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((jsonItem) => NotificationModel.fromJson(jsonItem))
          .toList();
    } else {
      print("🔴 Error ${response.statusCode}: ${response.body}");
      throw Exception('Failed to load notifications');
    }
  }

  // Mark a notification as read
  Future<bool> markAsRead(int id) async {
    final uri = Uri.parse('$baseUrl/api/notifications/$id/mark-read');
    print("📨 Marking as read: $uri");

    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print("🔴 Failed to mark as read - ${response.statusCode}: ${response.body}");
      return false;
    }
  }
}
