import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/images/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/add_to_cart_btn.dart';
import '../../../../core/widgets/image_with_fav.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../router/app_router.dart';
import '../../../home/ui/widget/screens/home_screen.dart';
import '../../data/models/product.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RouteName.product, arguments: product),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0).r,
        child: SizedBox(
          height: 250.0.h,
          width: 180.0.w,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 10.0).r,
                  height: 150.0.h,
                  width: 180.0.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0.r),
                      color: AppColorManager.fc),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DrawableText(
                        fontFamily: FontManager.cairoBold,
                        text: product.name,
                        size: product.name.length > 25 ? 12.0.spMin : 14.0.spMin,
                        maxLines: 1,
                        padding:
                            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0).r,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                DrawableText(
                                  drawableAlin: DrawableAlin.between,
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                                  text: product.getOfferPrice,
                                ),
                                product.isOffer?
                                  StrikeThroughWidget(
                                    child: DrawableText(
                                      text: product.getPrice,
                                      size: 12.0.spMin,
                                    ),
                                  ):20.0.verticalSpace,
                              ],
                            ),
                          ),
                          AddToCartBtn(product: product),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ImageWithFav(
                  product: product,
                  width: 140.0.r,
                  height: 140.0.r,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemOrderProduct extends StatelessWidget {
  const ItemOrderProduct({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      cardColor: AppColorManager.f6,
      elevation: 0.0,
      padding: const EdgeInsets.all(5.0).r,
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0).r,
      child: SizedBox(
        height: 85.0.h,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  DrawableText(
                    fontFamily: FontManager.cairoBold,
                    text: product.name,
                    maxLines: 1,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0).r,
                  ),
                  DrawableText(text: 'المجموع: ${product.getOfferPrice}'),
                  DrawableText(text: 'الكمية: ${product.quantity}'),
                ],
              ),
            ),
            SizedBox(
              width: 140.0.r,
              height: 140.0.r,
              child: ImageMultiType(
                width: 140.0.r,
                height: 140.0.r,
                url: product.cover.first,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemProductH extends StatelessWidget {
  const ItemProductH({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RouteName.product, arguments: product),
      child: MyCardWidget(
        cardColor: AppColorManager.f6,
        elevation: 0.0,
        padding: const EdgeInsets.all(15.0).r,
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0).r,
        child: SizedBox(
          height: 120.0.h,
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 120.0.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      DrawableText(
                        fontFamily: FontManager.cairoBold,
                        text: product.name,
                        padding:
                            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0).r,
                      ),
                      IgnorePointer(
                        child: DrawableText(
                          text: product.getOfferPrice,
                          drawablePadding: 10.0.w,
                          drawableStart: product.isOffer
                              ? StrikeThroughWidget(
                                  child: DrawableText(
                                    text: product.getPrice,
                                    size: 12.0.spMin,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      AddToCartBtn(product: product),
                    ],
                  ),
                ),
              ),
              ImageWithFav(
                width: 140.0.r,
                height: 140.0.r,
                product: product,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
