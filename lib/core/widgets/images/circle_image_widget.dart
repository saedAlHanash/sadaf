import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sadaf/core/util/my_style.dart';

import 'image_multi_type.dart';

class CircleImageWidget extends StatelessWidget {
  const CircleImageWidget({
    Key? key,
    this.size,
    required this.url,
    this.color,
    this.margin,
    this.padding,
    this.file,
  }) : super(key: key);

  final double? size;
  final String url;
  final XFile? file;
  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final imageRadios = size ?? 150.0.r;
    return Container(
      height: imageRadios,
      width: imageRadios,
      margin: margin,
      clipBehavior: Clip.hardEdge,
      padding: padding,
      decoration: BoxDecoration(
          color: color ?? Colors.white,
          shape: BoxShape.circle,
          boxShadow: MyStyle.lightShadow),
      child: ImageMultiType(
        url: url,
        file: file,
        fit: BoxFit.fill,
      ),
    );
  }
}
