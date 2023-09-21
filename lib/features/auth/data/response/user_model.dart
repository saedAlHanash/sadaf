//
// class UserModel {
//   UserModel({
//     required this.token,
//     required this.user,
//   });
//
//   final String token;
//   final User user;
//
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       token: json["token"] ?? "",
//       user: User.fromJson(json["user"] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "token": token,
//         "user": user.toJson(),
//       };
// }
//
// class User {
//   User({
//     required this.id,
//     required this.name,
//     required this.mobile,
//     required this.email,
//     required this.status,
//   });
//
//   final int id;
//   final String name;
//   final String mobile;
//   final String email;
//   final num status;
//
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json["id"] ?? 0,
//       name: json["name"] ?? "",
//       mobile: json["mobile"] ?? "",
//       email: json["email"] ?? "",
//       status: json["status"] ?? 0,
//
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "mobile": mobile,
//         "email": email,
//         "status": status,
//       };
// }
