import 'package:cached_network_image/cached_network_image.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../router/app_router.dart';
import '../../../catigories/data/models/category.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0.h,
      width: 129.0.w,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage(Assets.iconsTemp1), fit: BoxFit.fill),
      ),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, RouteName.category, arguments: category),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 120.0.h,
              width: 129.0.w,
              color: Colors.black.withOpacity(0.2),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageMultiType(
                  url: Assets.iconsKitchen,
                  height: 30.0.r,
                  width: 30.0.r,
                ),
                8.0.verticalSpace,
                DrawableText(
                  text: 'Kitchen',
                  size: 16.0.sp,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
