import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';

import '../../../../generated/assets.dart';
import '../../../product/ui/widget/price_screen.dart';

class ItemFavWidget extends StatelessWidget {
  const ItemFavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115.0.h,
      width: 1.0.sw,
      child: Row(
        children: [
          31.0.horizontalSpace,
          Container(
            height: 115.0.r,
            width: 115.0.r,
            color: AppColorManager.lightGray,
            padding: const EdgeInsets.all(8.0).r,
            child: ImageMultiType(
              url: Assets.iconsTemp2,
              height: 100.0.r,
              width: 100.0.r,
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 13.0).h,
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: AppColorManager.dividerColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DrawableText(
                          text: 'GLASS  CHAIR',
                          maxLines: 1,
                          matchParent: true,
                        ),
                        DrawableText(
                          text: '1.000.000',
                          color: AppColorManager.redPrice,
                          matchParent: true,
                          drawablePadding: 10.0.w,
                          drawableAlin: DrawableAlin.withText,
                          drawableEnd: DrawableText(
                            text: '4.000.000',
                            size: 12.0.sp,
                          ),
                        ),
                        const ReviewWidget(),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Icon(Icons.favorite, color: Colors.black),
                      ),
                      Container(
                        height: 25.0.r,
                        width: 25.0.r,
                        color: Colors.black,
                        child: InkWell(
                          onTap: () {},
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  30.0.horizontalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
