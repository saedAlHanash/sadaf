class ErrorResponse {
  ErrorResponse({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
  });

  final dynamic result;
  final dynamic targetUrl;
  final bool success;
  final Error error;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      result: json["result"],
      targetUrl: json["targetUrl"],
      success: json["success"] ?? false,
      error: json["error"] == null
          ? Error.initial()
          : Error.fromJson(json["error"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result,
        "targetUrl": targetUrl,
        "success": success,
        "error": error.toJson(),
      };
}

class Error {
  Error({
    required this.code,
    required this.message,
    required this.details,
    required this.validationErrors,
  });

  factory Error.initial() {
    return Error.fromJson({});
  }

  final int code;
  final String message;
  final dynamic details;
  final dynamic validationErrors;

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      code: json["code"] ?? 0,
      message: json["message"] ?? "",
      details: json["details"] ?? '',
      validationErrors: json["validationErrors"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "details": details,
        "validationErrors": validationErrors,
      };
}
