import '../../../../core/strings/enum_manager.dart';

class OrderStatusResponse {
  OrderStatusResponse({
    required this.data,
  });

  final List<OrderStatusResult> data;

  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) {
    return OrderStatusResponse(
      data: json["data"] == null
          ? []
          : List<OrderStatusResult>.from(
              json["data"]!.map((x) => OrderStatusResult.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class OrderStatusResult {
  OrderStatusResult({
    required this.id,
    required this.status,
    required this.changeAt,
  });

  final int id;
  final OrderStatus status;
  final DateTime? changeAt;

  factory OrderStatusResult.fromJson(Map<String, dynamic> json) {
    return OrderStatusResult(
      id: json["id"] ?? 0,
      status: OrderStatus.values[(int.tryParse(json["status"].toString()) ?? 1) - 1],
      changeAt: DateTime.tryParse(json["change_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "change_at": changeAt?.toIso8601String(),
      };
}
