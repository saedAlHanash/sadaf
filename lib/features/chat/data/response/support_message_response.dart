class SupportMessageResponse {
  SupportMessageResponse({
    required this.data,
  });

  final List<Room> data;

  factory SupportMessageResponse.fromJson(Map<String, dynamic> json){
    return SupportMessageResponse(
      data: json["data"] == null ? [] : List<Room>.from(json["data"]!.map((x) => Room.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x.toJson()).toList(),
  };

}

class Room {
  Room({
    required this.id,
    required this.lastMessage,
    required this.open,
    required this.user,
  });

  final int id;
  final String lastMessage;
  final bool open;
  final User user;

  factory Room.fromJson(Map<String, dynamic> json){
    return Room(
            id: int.tryParse(json["id"].toString()) ?? 0,
      lastMessage: json["last_message"] ?? "",
      open: json["open"] ?? false,
      user: User.fromJson(json["user"]??{}),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "last_message": lastMessage,
    "open": open,
    "user": user.toJson(),
  };

}

class User {
  User({
    required this.id,
    required this.name,
    required this.avatar,
  });

  final int id;
  final String name;
  final String avatar;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
            id: int.tryParse(json["id"].toString()) ?? 0,
      name: json["name"] ?? "",
      avatar: json["avatar"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
  };

}
