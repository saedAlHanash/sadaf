import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/products_response.dart';

class AddToCartBtn extends StatelessWidget {
  const AddToCartBtn({super.key, required this.product});

  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.0.h,
      width: 1.0.sw,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColorManager.mainColorLight,
            AppColorManager.mainColor,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
      child: DrawableText(
        text: S.of(context).add_to_cart,
        matchParent: true,
        color: Colors.white,
        fontFamily: FontManager.cairoBold,
        size: 24.0.sp,
        textAlign: TextAlign.center,
        drawableEnd: ImageMultiType(
          height: 26.0.r,
          width: 26.0.r,
          url: Assets.iconsBag,
          color: Colors.white,
        ),
      ),
    );
  }
}
