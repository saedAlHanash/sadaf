import 'package:sadaf/core/extensions/extensions.dart';

class UpdateProfileRequest {
  UpdateProfileRequest({
    this.name,
    this.mobile,
    this.email,
    this.photoID,
  });

  String? name;
  String? mobile;
  String? email;
  int? photoID;

  String? path;

  UpdateProfileRequest copyWith({
    String? name,
    String? mobile,
    String? email,
    int? photoID,
  }) {
    return UpdateProfileRequest(
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      photoID: photoID ?? this.photoID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mobile': mobile?.fixPhone(),
      'email': email,
      'photoID': photoID,
    };
  }

  factory UpdateProfileRequest.fromMap(Map<String, dynamic> map) {
    return UpdateProfileRequest(
      name: map['name'] as String,
      mobile: map['mobile'] as String,
      email: map['email'] as String,
      photoID: map['photoID'] as int,
    );
  }
}
