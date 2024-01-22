import 'package:sadaf/core/api_manager/api_service.dart';

class MessageRequest {
  String? message;
  List<UploadFile> file =[];

  MessageRequest({
    this.message,

  });

  MessageRequest copyWith({
    String? message,
    UploadFile? file,
  }) {
    return MessageRequest(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  factory MessageRequest.fromMap(Map<String, dynamic> map) {
    return MessageRequest(
      message: map['message'] ?? '',
    );
  }
}
