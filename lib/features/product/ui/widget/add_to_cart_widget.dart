import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/add_to_cart_btn.dart';
import 'package:sadaf/features/product/data/models/product.dart';
import 'package:slide_action/slide_action.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../../home/ui/widget/screens/home_screen.dart';

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0.sw,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColorManager.mainColor,
        borderRadius: BorderRadius.circular(200.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 12,
            child: SlideAction(
              rightToLeft: true,
              thumbHitTestBehavior: HitTestBehavior.deferToChild,
              thumbWidth: 70.0.r,
              trackHeight: 60.0.r,
              trackBuilder: (context, currentState) {
                return Container(
                  width: 150.0.w,
                  padding: const EdgeInsets.all(10.0).r,
                  decoration: BoxDecoration(
                      color: AppColorManager.lightGray,
                      border: Border.all(
                        color: AppColorManager.lightGray,
                        width: 1.0.spMin,
                      ),
                      borderRadius: BorderRadius.circular(200.0)),
                  alignment: Alignment.centerLeft,
                  child: DrawableText(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                    text: 'اضف الى السلة',
                    fontFamily: FontManager.cairoBold,
                    color: AppColorManager.mainColor,
                  ),
                );
              },
              thumbBuilder: (context, currentState) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: IconAddToCartWidget(product: product),
                );
              },
              action: () async {
                await Future.delayed(
                  const Duration(milliseconds: 100),
                  () => context.read<AddToCartCubit>().addToCart(),
                );
              },
            ),
          ),
          Expanded(
            flex: 10,
            child: Column(
              children: [
                DrawableText(
                  text: product.getOfferPrice,
                  drawablePadding: 10.0.w,
                  color: Colors.white,
                  textAlign: TextAlign.end,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                ),
                if(product.isOffer)
                StrikeThroughWidget(

                  child: DrawableText(
                    color: Colors.white,
                    text: product.getPrice,
                    size: 12.0.spMin,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
