class NotificationModel {
  final String title;
  final String message;
  final String time;
  final bool unread;

  NotificationModel({
    required this.title,
    required this.message,
    required this.time,
    required this.unread,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      message: json['message'],
      time: json['time'],
      unread: json['unread'] == "true",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'time': time,
      'unread': unread.toString(),
    };
  }
}
