import 'package:sadaf/core/strings/app_string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../strings/app_color_manager.dart';
import '../strings/enum_manager.dart';
import 'package:drawable_text/drawable_text.dart';

class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget({Key? key, this.onCompleted, this.onChange}) : super(key: key);
  final Function(String)? onCompleted;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: AppColorManager.black,
      fontFamily: FontManager.cairoBold.name,
      fontSize: 20.0.spMin,
    );

    final defaultPinTheme = PinTheme(
      width: 40.0.w,
      height: 50.0.h,
      textStyle: textStyle,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0.r),
        color: AppColorManager.lightGray,
      ),
    );

    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Pinput(
          length: 4,
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
          onCompleted: onCompleted,
          onChanged: onChange,
        ),
      ),
    );
  }
}
