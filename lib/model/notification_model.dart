class NotificationModel {
  int? id;
  String? title;
  String? content;
  String? date;
  bool? isRead;

  NotificationModel(
      {this.id, this.title, this.content, this.date, this.isRead});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['date'] = this.date;
    data['isRead'] = this.isRead;
    return data;
  }
}