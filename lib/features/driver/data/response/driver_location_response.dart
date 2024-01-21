import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverLocationResponse {
  DriverLocationResponse({
    required this.data,
  });

  final Data data;

  factory DriverLocationResponse.fromJson(Map<String, dynamic> json) {
    return DriverLocationResponse(
      data: Data.fromJson(json["data"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.coordinate,
  });

  final Coordinate coordinate;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      coordinate: Coordinate.fromJson(json["coordinate"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "coordinate": coordinate.toJson(),
      };
}

class Coordinate {
  LatLng? get latLng => latitude==0?null:LatLng(latitude, longitude);

  Coordinate({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      latitude: double.tryParse(json["latitude"].toString()) ?? 0,
      longitude: double.tryParse(json["longitude"].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
