
class CheckCouponResponse {
  CheckCouponResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  final bool result;
  final String message;
  final CheckCouponResult? data;

  factory CheckCouponResponse.fromJson(Map<String, dynamic> json){
    return CheckCouponResponse(
      result: json["result"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] == null ? null : CheckCouponResult.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data?.toJson(),
  };

}

class CheckCouponResult {
  CheckCouponResult({
    required this.totalPrice,
    required this.offer,
  });

  final num totalPrice;
  final String offer;

  factory CheckCouponResult.fromJson(Map<String, dynamic> json){
    return CheckCouponResult(
      totalPrice: num.tryParse(json["total_price"].toString()) ?? 0,
      offer: json["offer"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "total_price": totalPrice,
    "offer": offer,
  };

}
