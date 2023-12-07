class ProfileResponse {
  ProfileResponse({
    required this.data,
  });

  final Profile? data;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      data: json["data"] == null ? null : Profile.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Profile {
  Profile({
    required this.name,
    required this.emailOrPhone,
    required this.mapAddress,
    required this.address,
    required this.avatar,
  });

  final String name;
  final String emailOrPhone;
  final String mapAddress;
  final String address;
  final String avatar;



  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json["name"] ?? "",
      emailOrPhone: json["email_or_phone"] ?? "",
      mapAddress: json["map_address"] ?? "",
      address: json["address"] ??'',
      avatar: json["avatar"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email_or_phone": emailOrPhone,
        "map_address": mapAddress,
        "address": address,
        "avatar": avatar,
      };
}


