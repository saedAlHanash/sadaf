import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../generated/assets.dart';
import '../../bloc/get_cart_cubit/get_cart_cubit.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key, this.isAppBar = false});

  final bool isAppBar;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isAppBar ? 70.0.w : null,
      child: Stack(
        children: [
          Center(
            child: ImageMultiType(
              url: Assets.iconsCart,
              color: isAppBar ? AppColorManager.mainColor : Colors.white,
              height: isAppBar ? 30.0.r : 25.0.r,
            ),
          ),
          BlocBuilder<CartCubit, CartInitial>(
            builder: (context, state) {
              return Positioned(
                top: isAppBar ? 20.0.h : 0,
                right: isAppBar ? 10.0.w : 15.0.w,
                child: Container(
                  height: 21.0.r,
                  width: 21.0.r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColorManager.mainColor, width: 3.0.r),
                  ),
                  child: Center(
                    child: DrawableText(
                      text: (state.result.products.length < 10)
                          ? state.result.products.length.toString()
                          : '9+',
                      color: AppColorManager.mainColor,
                      size: state.result.products.length < 10 ? 10.0.sp : 8.0.sp,
                      fontFamily: FontManager.cairoBold.name,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
