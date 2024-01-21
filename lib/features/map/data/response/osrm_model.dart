class OsrmModel {
  OsrmModel({
    required this.code,
    required this.routes,
  });

  final String code;
  final List<OsrmRoute> routes;

  factory OsrmModel.fromJson(Map<String, dynamic> json) {
    return OsrmModel(
      code: json["code"] ?? "",
      routes: json["routes"] == null
          ? []
          : List<OsrmRoute>.from(json["routes"]!.map((x) => OsrmRoute.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "routes": routes.map((x) => x.toJson()).toList(),
      };
}

class OsrmRoute {
  OsrmRoute({
    required this.geometry,
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
  });

  final String geometry;
  final String weightName;
  final num weight;
  final num duration;
  final num distance;

  factory OsrmRoute.fromJson(Map<String, dynamic> json) {
    return OsrmRoute(
      geometry: json["geometry"] ?? "",
      weightName: json["weight_name"] ?? "",
      weight: json["weight"] ?? 0,
      duration: json["duration"] ?? 0,
      distance: json["distance"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "geometry": geometry,
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
      };
}
