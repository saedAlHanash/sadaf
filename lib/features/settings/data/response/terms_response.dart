class TermsResponse {
  TermsResponse({
    required this.data,
  });

  final List<Terms> data;

  factory TermsResponse.fromJson(Map<String, dynamic> json){
    return TermsResponse(
      data: json["data"] == null ? [] : List<Terms>.from(json["data"]!.map((x) => Terms.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x?.toJson()).toList(),
  };

}

class Terms {
  Terms({
    required this.id,
    required this.name,
    required this.slug,
    required this.body,
  });

  final dynamic id;
  final String name;
  final String slug;
  final String body;

  factory Terms.fromJson(Map<String, dynamic> json){
    return Terms(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
      body: json["body"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "body": body,
  };

}
