
class ManufacturersResponse {
  ManufacturersResponse({
    required this.data,
  });

  final List<Manufacturer> data;

  factory ManufacturersResponse.fromJson(Map<String, dynamic> json) {
    return ManufacturersResponse(
      data: json["data"] == null
          ? []
          : List<Manufacturer>.from(json["data"]!.map((x) => Manufacturer.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Manufacturer {
  Manufacturer({
    required this.id,
    required this.name,

  });

  final int id;
  final String name;

  factory Manufacturer.fromJson(Map<String, dynamic> json) {
    return Manufacturer(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,

      };
}
