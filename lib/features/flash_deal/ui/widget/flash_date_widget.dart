import 'dart:async';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/flash_deal/data/models/flash_deal.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../generated/l10n.dart';
class DateTimeWidget extends StatefulWidget {
  const DateTimeWidget({super.key, required this.dateTime});

  final DateTime dateTime;

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  Timer? _timer;

  String d = '-';
  String h = '-';
  String m = '-';

  @override
  void initState() {
    setTimes();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      setState(() => setTimes());
    });
    super.initState();
  }

  void setTimes() {
    final f = widget.dateTime.getFormat(serverDate: serverDateTime);


    d = ((f.months * 30) + f.days).toString();
    h = (f.hours).toString();
    m = (f.minutes).toString();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DrawableText(
          size: 12.0.sp,
          text: S.of(context).days,
          matchParent: true,
          drawableAlin: DrawableAlin.between,
          drawablePadding: 10.0.w,
          drawableStart: DrawableText(
            text: d,
            fontFamily: FontManager.cairoBold.name,
            size: 13.0.sp,
          ),
        ),
        DrawableText(
          size: 12.0.sp,
          text: S.of(context).hours,
          matchParent: true,
          drawableAlin: DrawableAlin.between,
          drawablePadding: 10.0.w,
          drawableStart: DrawableText(
            text: h,
            fontFamily: FontManager.cairoBold.name,
            size: 13.0.sp,
          ),
        ),
        DrawableText(
          size: 12.0.sp,
          text: S.of(context).min,
          matchParent: true,
          drawableAlin: DrawableAlin.between,
          drawablePadding: 10.0.w,
          drawableStart: DrawableText(
            text: m,
            fontFamily: FontManager.cairoBold.name,
            size: 13.0.sp,
          ),
        ),
      ],
    );
  }
}
