import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../strings/app_color_manager.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    this.child,
    this.onTap,
    this.text = '',
    this.color,
    this.elevation,
    this.textColor,
    this.width,
    this.enable,
    this.toUpper = true,
    this.padding,
  }) : super(key: key);

  final Widget? child;
  final String text;
  final Color? textColor;
  final Color? color;
  final double? elevation;
  final double? width;
  final bool? enable;
  final EdgeInsets? padding;
  final Function()? onTap;
  final bool toUpper;

  @override
  Widget build(BuildContext context) {
    final child = this.child ??
        DrawableText(
          text:toUpper?text.toUpperCase(): text,
          color: textColor ?? AppColorManager.whit,
          fontFamily: FontManager.cairoBold.name,
        );

    return SizedBox(
      width: width ?? .9.sw,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(color),
          // padding: MaterialStatePropertyAll(padding),
          padding: MaterialStatePropertyAll(const EdgeInsets.symmetric(vertical: 13.0).r),
          alignment: Alignment.center,
        ),
        onPressed: !(enable ?? true) ? null : onTap,
        child: child,
      ),
    );
  }
}
