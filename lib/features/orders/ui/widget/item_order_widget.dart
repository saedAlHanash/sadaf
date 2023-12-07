import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../router/app_router.dart';
import '../../data/response/my_orders.dart';

class ItemOrderWidget extends StatelessWidget {
  const ItemOrderWidget({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.orderInfo, arguments: order);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 30.0).w,
        padding: const EdgeInsets.only(right: 30.0, left: 5.0, top: 20.0, bottom: 20.0).r,
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: AppColorManager.black,
              width: 1.0.h,
            ),
          ),
        ),
        child: Column(
          children: [
            DrawableText(
              text: '#${order.id}',
              matchParent: true,
              size: 16.0.sp,
              drawableAlin: DrawableAlin.between,
              drawableEnd: DrawableText(
                text: order.total,
                fontFamily: FontManager.cairoBold,
              ),
            ),
            10.0.verticalSpace,
            DrawableText(
              text: 'Progress',
              matchParent: true,
              drawableAlin: DrawableAlin.between,
              drawableEnd: DrawableText(
                size: 14.0.sp,
                color: Colors.grey,
                text: DateTime.now().formatDateTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
