class Categories {
  Categories({
    required this.data,
  });

  final List<Category> data;

  factory Categories.fromJson(Map<String, dynamic> json) {
    if (json["data"] is! List) {
      return Categories(
        data: [Category.fromJson(json['data'] ?? {})],
      );
    }

    return Categories(
      data: json["data"] == null
          ? []
          : List<Category>.from(json["data"]!.map((x) => Category.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.icon,
  });

  final int id;
  final String name;
  final String image;
  final String icon;

  // ------
  bool selected = false;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
            id: int.tryParse(json["id"].toString()) ?? 0,
      name: json["name"] ?? "",
      image: json["image"] ?? json["icon"] ?? "",
      icon: json["icon"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "icon": icon,
      };
}
