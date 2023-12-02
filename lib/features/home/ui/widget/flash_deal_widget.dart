import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../generated/l10n.dart';

class FlashDealWidget extends StatelessWidget {
  const FlashDealWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
      width: 1.0.sw,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DrawableText(
                  size: 12.0.sp,
                  text: S.of(context).days,
                  matchParent: true,
                  drawableAlin: DrawableAlin.between,
                  drawablePadding: 10.0.w,
                  drawableStart: DrawableText(
                    text: '20',
                    fontFamily: FontManager.cairoBold,
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
                    text: '20',
                    fontFamily: FontManager.cairoBold,
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
                    text: '20',
                    fontFamily: FontManager.cairoBold,
                    size: 13.0.sp,
                  ),
                ),
              ],
            ),
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
                    url: Assets.iconsTemp2,
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
                          text: 'Dining Chair',
                          fontFamily: FontManager.cairoBold,
                        ),
                        DrawableText(
                          size: 14.0.sp,
                          fontFamily: FontManager.cairoBold,
                          text: 100000.formatPrice,
                          color: AppColorManager.red,
                        ),
                        DrawableText(
                          size: 8.0.sp,
                          text: 400000.formatPrice,
                          color: AppColorManager.gray,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            DrawableText(
                              size: 10.0.sp,
                              text: S.of(context).back,
                              drawableStart: ImageMultiType(
                                url: Icons.keyboard_arrow_left_rounded,
                                height: 8.0.sp,
                              ),
                            ),
                            DrawableText(
                              size: 10.0.sp,
                              text: S.of(context).next,
                              drawableEnd: ImageMultiType(
                                url: Icons.keyboard_arrow_right_rounded,
                                height: 8.0.sp,
                              ),
                            ),
                          ],
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
  const FlashDealWidgetFullCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorManager.f8,
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0).r,
      width: 1.0.sw,
      height: 122.0.h,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DrawableText(
                  size: 12.0.sp,
                  text: S.of(context).days,
                  matchParent: true,
                  drawableAlin: DrawableAlin.between,
                  drawablePadding: 10.0.w,
                  drawableStart: DrawableText(
                    text: '20',
                    fontFamily: FontManager.cairoBold,
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
                    text: '20',
                    fontFamily: FontManager.cairoBold,
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
                    text: '20',
                    fontFamily: FontManager.cairoBold,
                    size: 13.0.sp,
                  ),
                ),
              ],
            ),
          ),
          15.0.horizontalSpace,
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageMultiType(
                  url: Assets.iconsTemp2,
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
                        text: 'Dining Chair',
                        fontFamily: FontManager.cairoBold,
                      ),
                      DrawableText(
                        size: 12.0.sp,
                        fontFamily: FontManager.cairoBold,
                        text: 100000.formatPrice,
                        color: AppColorManager.red,
                      ),
                      DrawableText(
                        size: 8.0.sp,
                        text: 400000.formatPrice,
                        color: AppColorManager.gray,
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
