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

class FlashDealWidget extends StatelessWidget {
  const FlashDealWidget({super.key, required this.item});

  final FlashDeal item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
      width: 1.0.sw,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DateTimeWidget(dateTime: item.discountEndAt ?? serverDateTime),
          ),
          15.0.horizontalSpace,
          Expanded(
            flex: 4,
            child: Container(
              height: double.infinity,
              color: AppColorManager.f8,
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0).r,
              child: Row(
                children: [
                  ImageMultiType(
                    url: item.thumbnail,
                    height: 81.0.r,
                    width: 81.0.r,
                  ),
                  20.0.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawableText(
                          size: 14.0.sp,
                          maxLines: 1,
                          text: item.name,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                        DrawableText(
                          size: 14.0.sp,
                          fontFamily: FontManager.cairoBold.name,
                          text: item.price.formatPrice,
                          color: AppColorManager.black,
                        ),
                        DrawableText(
                          size: 8.0.sp,
                          text: item.discountPrice.formatPrice,
                          color: AppColorManager.redPrice,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlashDealWidgetFullCard extends StatelessWidget {
  const FlashDealWidgetFullCard({super.key, required this.item});

  final FlashDeal item;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorManager.f8,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0).r,
      width: 1.0.sw,
      height: 122.0.h,
      child: Row(
        children: [
          Expanded(
            child: DateTimeWidget(dateTime: item.discountEndAt ?? serverDateTime),
          ),
          15.0.horizontalSpace,
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageMultiType(
                  url: item.thumbnail,
                  height: 100.0.r,
                  width: 100.0.r,
                ),
                20.0.horizontalSpace,
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DrawableText(
                        size: 14.0.sp,
                        text: item.name,
                        maxLines: 1,
                        fontFamily: FontManager.cairoBold.name,
                      ),
                      DrawableText(
                        size: 12.0.sp,
                        maxLines: 1,
                        fontFamily: FontManager.cairoBold.name,
                        text: item.price.formatPrice,
                        color: AppColorManager.black,
                      ),
                      DrawableText(
                        size: 8.0.sp,
                        maxLines: 1,
                        text: item.discountPrice.formatPrice,
                        color: AppColorManager.redPrice,
                        matchParent: true,
                        drawableAlin: DrawableAlin.between,
                        drawableEnd: ImageMultiType(
                          height: 18.0.r,
                          width: 18.0.r,
                          url: Assets.iconsBag,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

    loggerObject.wtf(f.toString());
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
