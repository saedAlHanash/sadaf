class ConfirmCodeResponse {
  ConfirmCodeResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  final bool result;
  final String message;
  final ConfirmCodeData data;

  factory ConfirmCodeResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmCodeResponse(
      result: json["result"] ?? false,
      message: json["message"] ?? "",
      data: ConfirmCodeData.fromJson(json["data"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data.toJson(),
      };
}

class ConfirmCodeData {
  ConfirmCodeData({
    required this.token,
    required this.name,
    required this.phone,
    required this.address,
    required this.city,
    required this.id,
    required this.country,
  });

   String token;
   String name;
   String phone;
   String address;
   String city;
   int id;
   String country;

  factory ConfirmCodeData.fromJson(Map<String, dynamic> json) {
    return ConfirmCodeData(
      token: json["token"] ?? "",
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      address: json["address"] ?? "",
      city: json["city"] ?? "",
      country: json["country"] ?? "",
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "phone": phone,
        "address": address,
        "city": city,
        "country": country,
      };
}
