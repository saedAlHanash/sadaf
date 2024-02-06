

class GovernorsResponse {
  GovernorsResponse({
    required this.data,
  });

  final List<GovernorModel> data;

  factory GovernorsResponse.fromJson(Map<String, dynamic> json) {
    return GovernorsResponse(
      data: json["data"] == null
          ? []
          : List<GovernorModel>.from(json["data"]!.map((x) => GovernorModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class GovernorModel {
  GovernorModel({
    required this.id,
    required this.name,
    required this.deliveryTime,
    required this.price,
    required this.currency,
  });

  final int id;
  final String name;
  final String deliveryTime;
  final String price;
  final String currency;

  factory GovernorModel.fromJson(Map<String, dynamic> json) {
    return GovernorModel(
            id: int.tryParse(json["id"].toString()) ?? 0,
      name: json["name"] ?? "",
      deliveryTime: json["delivery_time"] ?? "",
      price: json["price"] ?? "",
      currency: json["currency"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "delivery_time": deliveryTime,
        "price": price,
        "currency": currency,
      };
}
