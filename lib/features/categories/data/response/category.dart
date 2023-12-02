class Categories {
  Categories({
    required this.data,
  });

  final List<Category> data;

  factory Categories.fromJson(Map<String, dynamic> json) {
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
  });

  final int id;
  final String name;
  final String image;

  // ------
  bool selected = false;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      image: json["image"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
