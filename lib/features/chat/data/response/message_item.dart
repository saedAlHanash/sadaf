import '../../../orders/data/response/orders_response.dart';

class MessageModel {
  int id;
  int conversationId;
  String senderType;
  String body;
  bool isFile;
  String createdAt;
  Driver driver;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderType,
    required this.body,
    required this.isFile,
    required this.createdAt,
    required this.driver,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json["id"],
    conversationId: json["conversation_id"],
    senderType: json["sender_type"],
    body: json["body"],
    isFile: json["is_file"],
    createdAt: json["created_at"],
    driver: Driver.fromJson(json["driver"]??{}),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "conversation_id": conversationId,
    "sender_type": senderType,
    "body": body,
    "is_file": isFile,
    "created_at": createdAt,
    "driver": driver.toJson(),
  };
}

