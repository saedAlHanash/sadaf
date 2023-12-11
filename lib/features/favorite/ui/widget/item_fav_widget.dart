import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/features/product/ui/widget/add_to_cart_btn.dart';

import '../../../../core/util/my_style.dart';
import '../../../cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../bloc/add_favorite/add_favorite_cubit.dart';
import '../../data/response/fav_response.dart';

class ItemFavWidget extends StatelessWidget {
  const ItemFavWidget({super.key, required this.fav});

  final Fav fav;

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
              url: fav.thumbnail,
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
                        DrawableText(
                          text: fav.name,
                          maxLines: 1,
                          matchParent: true,
                        ),
                        DrawableText(
                          text: fav.price,
                          color: AppColorManager.black,
                          matchParent: true,
                          drawablePadding: 10.0.w,
                          drawableAlin: DrawableAlin.withText,
                          drawableEnd: DrawableText(
                            text: fav.discountPrice,
                            size: 12.0.sp,
                            color: AppColorManager.redPrice,
                          ),
                        ),
                        // ReviewWidget(rate: 0),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<AddFavoriteCubit, AddFavoriteInitial>(
                        buildWhen: (p, c) => c.product.id == fav.id,
                        builder: (context, state) {
                          if (state.statuses.loading) {
                            return MyStyle.loadingWidget();
                          }
                          return InkWell(
                            onTap: () {
                              context
                                  .read<AddFavoriteCubit>()
                                  .removeFav(productId: fav.id);
                            },
                            child: const Icon(Icons.favorite, color: Colors.black),
                          );
                        },
                      ),
                      AddToCartBtnFav(fav: fav),
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
