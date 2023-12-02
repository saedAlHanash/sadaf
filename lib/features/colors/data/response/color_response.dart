import 'package:flutter/material.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';

class ColorsResponse {
  ColorsResponse({
    required this.data,
  });

  final List<ColorModel> data;

  factory ColorsResponse.fromJson(Map<String, dynamic> json) {
    return ColorsResponse(
      data: json["data"] == null
          ? []
          : List<ColorModel>.from(json["data"]!.map((x) => ColorModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class ColorModel {
  ColorModel({
    required this.id,
    required this.name,
    required this.hex,
    required this.color,
  });

  final int id;
  final String name;
  final String hex;
  final Color color;

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    return ColorModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      hex: json["hex"] ?? "",
      color: getColorFromHex(json["hex"] ?? "fff"),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "hex": hex,
      };
}
