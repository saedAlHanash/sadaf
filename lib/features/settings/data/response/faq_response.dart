class FaqResponse {
  FaqResponse({
    required this.data,
  });

  final List<Faq> data;

  factory FaqResponse.fromJson(Map<String, dynamic> json){
    return FaqResponse(
      data: json["data"] == null ? [] : List<Faq>.from(json["data"]!.map((x) => Faq.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x.toJson()).toList(),
  };

}

class Faq {
  Faq({
    required this.id,
    required this.title,
    required this.body,
  });

  final int id;
  final String title;
  final String body;

  factory Faq.fromJson(Map<String, dynamic> json){
    return Faq(
      id: int.tryParse(json["id"].toString()) ?? 0,
      title: json["title"] ?? "",
      body: json["body"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
  };

}
