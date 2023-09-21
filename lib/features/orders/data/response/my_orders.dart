import '../../../product/data/models/product.dart';

class MyOrdersResponse {
  MyOrdersResponse({
    required this.result,
    required this.message,
    required this.data,
    required this.currentPage,
    required this.lastPage,
  });

  final bool result;
  final String message;
  final List<Order> data;
  final num currentPage;
  final num lastPage;

  factory MyOrdersResponse.fromJson(Map<String, dynamic> json) {
    return MyOrdersResponse(
      result: json["result"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] == null
          ? []
          : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
      currentPage: json["current_page"] ?? 0,
      lastPage: json["last_page"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
        "current_page": currentPage,
        "last_page": lastPage,
      };
}

class Order {
  Order({
    required this.id,
    required this.status,
    required this.totalPrice,
    required this.note,
    required this.details,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String status;
  final num totalPrice;
  final String note;
  final List<Items> details;
  final String createdAt;
  final String updatedAt;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"] ?? 0,
      status: json["status"] ?? "",
      totalPrice: json["total_price"] ?? 0,
      note: json["note"] ?? "",
      details: json["details"] == null
          ? []
          : List<Items>.from(json["details"]!.map((x) => Items.fromJson(x))),
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "total_price": totalPrice,
        "note": note,
        "details": details.map((x) => x.toJson()).toList(),
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Items {
  Items({
    required this.id,
    required this.quantity,
    required this.amount,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int quantity;
  final String amount;
  final Product product;
  final String createdAt;
  final String updatedAt;

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json["id"] ?? 0,
      quantity: json["quantity"] ?? 0,
      amount: json["amount"] ?? "",
      product: Product.fromJson(json["product"] ?? {}),
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "amount": amount,
        "product": product.toJson(),
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
