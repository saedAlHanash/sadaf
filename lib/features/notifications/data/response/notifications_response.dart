import '../../../product/data/response/products_response.dart';

class NotificationsResponse {
  NotificationsResponse({
    required this.data,
  });

  final List<NotificationModel> data;

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      data: json["data"] == null
          ? []
          : List<NotificationModel>.from(
              json["data"]!.map((x) => NotificationModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.notification,
    required this.createdAt,
  });

  final String id;
  final Notification notification;
  final String createdAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"] ?? "",
      notification: Notification.fromJson(json["notification"] ?? {}),
      createdAt: json["created_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "notification": notification.toJson(),
        "created_at": createdAt,
      };
}

class Notification {
  Notification({
    required this.title,
    required this.body,
    required this.conversationId,
  });

  final String title;
  final String body;
  final int conversationId;

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json["title"] ?? "",
      body: json["body"] ?? "",
      conversationId: int.tryParse(json["conversation_id"].toString())  ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "conversation_id": conversationId,
      };
}
