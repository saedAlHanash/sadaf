import 'package:cached_network_image/cached_network_image.dart';
import 'package:drawable_text/drawable_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../router/app_router.dart';
import '../../../product/data/request/product_filter_request.dart';
import '../../data/response/category.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0.h,
      width: 129.0.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(category.image),
          fit: BoxFit.fill,
        ),
      ),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteName.products,
            arguments: ProductFilterRequest(categoryId: category.id),
          );
        },
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
                  url: category.icon,
                  height: 30.0.r,
                  width: 30.0.r,
                ),
                8.0.verticalSpace,
                DrawableText(
                  text: category.name,
                  textAlign: TextAlign.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                  size: 12.0.sp,
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
