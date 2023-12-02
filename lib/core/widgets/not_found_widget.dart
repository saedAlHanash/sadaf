import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final String text;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageMultiType(
              url: icon,
              height: 250.0.spMin,
              width: 250.0.spMin,
            ),
            DrawableText(
              text: 'آسف !',
              fontFamily: FontManager.cairoBold,
              color: Colors.black,
              size: 20.0.spMin,
            ),
            10.0.verticalSpace,
            DrawableText(
              text: text,
              color: Colors.black,
              size: 16.0.spMin,
            )
          ],
        ),
      ),
    );
  }
}
