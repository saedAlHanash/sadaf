import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/request_models/command.dart';
import '../../../orders/data/response/orders_response.dart';

class MessageResponse extends AbstractMeta {
  MessageResponse({
    required this.data,
    required super.meta,
  });

  final List<MessageModel> data;

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      data: json["data"] == null
          ? []
          : List<MessageModel>.from(json["data"]!.map((x) => MessageModel.fromJson(x))),
      meta: Meta.fromJson(json["meta"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
        "meta": meta.toJson(),
      };
}

class MessageModel {
  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderType,
    required this.body,
    required this.isFile,
    required this.createdAt,
    required this.user,
  });

  final int id;
  final int conversationId;
  final String senderType;
  final dynamic body;
  final bool isFile;
  final String createdAt;
  final User user;

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json["id"] ?? 0,
      conversationId: json["conversation_id"] ?? 0,
      senderType: json["sender_type"] ?? "",
      body: json["body"] ?? "",
      isFile: json["is_file"] ?? false,
      createdAt: json["created_at"] ?? "",
      user: User.fromJson(json["user"] ?? json["driver"] ?? json["admin"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "conversation_id": conversationId,
        "sender_type": senderType,
        "body": body,
        "is_file": isFile,
        "created_at": createdAt,
        "user": user.toJson(),
      };
}
