class ProductFilterRequest {
  ProductFilterRequest({
    this.fromPrice,
    this.toPrice,
    this.categoryId,
    this.search,
  });

  num? fromPrice;
  num? toPrice;
  int? categoryId;
  String? search;

  factory ProductFilterRequest.fromJson(Map<String, dynamic> map) {
    return ProductFilterRequest(
      fromPrice: map['fromPrice'] ?? 0,
      toPrice: map['toPrice'] ?? 0,
      categoryId: map['category_id'] ?? 0,
      search: map['search'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromPrice': fromPrice,
      'toPrice': toPrice,
      'category_id': categoryId,
      'search': search,
    };
  }

  ProductFilterRequest copyWith({
    num? fromPrice,
    num? toPrice,
    int? categoryId,
    String? search,
  }) {
    return ProductFilterRequest(
      fromPrice: fromPrice ?? this.fromPrice,
      toPrice: toPrice ?? this.toPrice,
      categoryId: categoryId ?? this.categoryId,
      search: search ?? this.search,
    );
  }
}
