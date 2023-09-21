class SliderResponse {
  SliderResponse({
    required this.data,
  });

  final List<SliderResult> data;

  factory SliderResponse.fromJson(Map<String, dynamic> json) {
    return SliderResponse(
      data: json["data"] == null
          ? []
          : List<SliderResult>.from(json["data"]!.map((x) => SliderResult.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class SliderResult {
  SliderResult({
    required this.id,
    required this.cover,
  });

  final int id;
  final String cover;

  factory SliderResult.fromJson(Map<String, dynamic> json) {
    return SliderResult(
      id: json["id"] ?? 0,
      cover: json["cover"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
      };
}
