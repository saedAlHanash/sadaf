class Category {
  Category({
    required this.id,
    required this.name,
    required this.cover,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String cover;
  final String createdAt;
  final String updatedAt;

  bool isSub = false;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"] ?? json['category_id'] ?? 0,
      name: json["name"] ?? "",
      cover: json["cover"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cover": cover,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
