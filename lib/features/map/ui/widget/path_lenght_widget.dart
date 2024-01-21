import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PathLengthWidget extends StatelessWidget {
  const PathLengthWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      margin: EdgeInsets.only(bottom: 20.0.h),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontFamily: FontManager.cairoBold.name,
        ),
      ),
    );
  }
}
