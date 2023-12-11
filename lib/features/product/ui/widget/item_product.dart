import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/product/ui/widget/add_to_cart_btn.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../data/response/products_response.dart';

class ItemLargeProduct extends StatelessWidget {
  const ItemLargeProduct({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.product, arguments: product);
      },
      child: SizedBox(
        width: 255.0.w,
        child: MyCardWidget(
          cardColor: Colors.white,
          elevation: 5.0,
          radios: 0.0,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0).r,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0).r,
          child: Column(
            children: [
              ImageMultiType(
                height: 180.0.r,
                width: 180.0.r,
                url: product.thumbnail,
              ),
              14.0.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DrawableText(
                          matchParent: true,
                          maxLines: 1,
                          size: 18.0.sp,
                          text: product.name,
                          fontFamily: FontManager.cairoBold,
                        ),
                        DrawableText(
                          matchParent: true,
                          size: 20.0.sp,
                          fontFamily: FontManager.cairoBold,
                          text: product.price,
                          color: AppColorManager.black,
                        ),
                        DrawableText(
                          matchParent: true,
                          size: 15.0.sp,
                          text: product.discountPrice,
                          color: AppColorManager.redPrice,
                        ),
                      ],
                    ),
                  ),

                  AddToCartBag(product: product),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemHorizontalProduct extends StatelessWidget {
  const ItemHorizontalProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, RouteName.product, arguments: product);
      },
      child: SizedBox(
        width: 182.0.w,
        child: MyCardWidget(
          cardColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0).r,
          elevation: 3.0,
          child: Row(
            children: [
              ImageMultiType(
                url: Assets.iconsTemp2,
                height: 85.0.r,
                width: 85.0.r,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemRelatedProductProduct extends StatelessWidget {
  const ItemRelatedProductProduct({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.product, arguments: Product.fromJson({}));
      },
      child: SizedBox(
        width: width ?? 139.0.w,
        child: Column(
          children: [
            Container(
              color: AppColorManager.lightGray,
              width: 139.0.w,
              height: 192.0.h,
              child: Stack(
                children: [
                  Positioned(
                    height: 180.0.r,
                    width: 180.0.r,
                    top: 8.0.h,
                    child: ImageMultiType(
                      height: 180.0.r,
                      width: 180.0.r,
                      url: Assets.iconsTestPng,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: ImageMultiType(
                      width: 16.0.r,
                      height: 16.0.r,
                      url: Assets.iconsFav,
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 25.0.r,
                        width: 25.0.r,
                        color: Colors.black,
                        child: InkWell(
                          onTap: () {},
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
            DrawableText(
              text: 'GLASS  CHAIR',
              maxLines: 1,
              matchParent: true,
            ),
            DrawableText(
              text: '1.000.000',
              color: AppColorManager.redPrice,
              matchParent: true,
              drawableAlin: DrawableAlin.between,
              drawableEnd: DrawableText(
                text: '4.000.000',
                size: 12.0.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemProductOffer extends StatelessWidget {
  const ItemProductOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.product, arguments: Product.fromJson({}));
      },
      child: SizedBox(
        width: 120.0.w,
        child: Column(
          children: [
            ImageMultiType(
              height: 120.0.r,
              width: 120.0.r,
              url: Assets.iconsTestPng,
            ),
            DrawableText(
              text: 'GLASS  CHAIR',
              maxLines: 1,
              matchParent: true,
            ),
            DrawableText(
              text: '1.000.000',
              color: AppColorManager.redPrice,
              matchParent: true,
            ),
            DrawableText(
              matchParent: true,
              text: '4.000.000',
              size: 12.0.sp,
              color: Colors.grey,
              drawableAlin: DrawableAlin.between,
              drawableEnd: ImageMultiType(
                height: 18.0.r,
                width: 18.0.r,
                url: Assets.iconsBag,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemProduct extends StatelessWidget {
  const ItemProduct({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.product, arguments: product);
      },
      child: Container(
        color: AppColorManager.lightGray,
        width: 120.0.w,
        child: Column(
          children: [
            ImageMultiType(
              url: product.thumbnail,
              height: 120.0.r,
              width: 120.0.r,
            ),
            DrawableText(
              text: product.name,
              maxLines: 1,
              matchParent: true,
              size: 16.0.sp,
              color: AppColorManager.mainColorLight,
              fontFamily: FontManager.cairoBold,
            ),
            DrawableText(
              text: product.price.formatPrice,
              fontFamily: FontManager.cairoBold,
              matchParent: true,
              maxLines: 1,
              drawableAlin: DrawableAlin.between,
              drawableEnd: ImageMultiType(
                height: 25.0.r,
                width: 25.0.r,
                url: Assets.iconsBag,
              ),
            ),
            if (!product.discountPrice.isZero)
              DrawableText(
                matchParent: true,
                maxLines: 1,
                text: product.discountPrice.formatPrice,
                size: 12.0.sp,
                color: Colors.red,
              ),
            10.0.verticalSpace,
          ],
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
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.product, arguments: product);
      },
      child: Container(
        width: 1.0.sw,
        height: 60.0.h,
   margin: const EdgeInsets.symmetric(vertical: 15.0).h,
   padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
        child: Row(
          children: [
            ImageMultiType(
              url: Assets.iconsTemp2,
              height: 54.0.r,
              width: 54.0.r,
            ),
            20.0.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawableText(
                    size: 14.0.sp,
                    text: product.name,
                    fontFamily: FontManager.cairoBold,
                    matchParent: true,
                    drawableAlin: DrawableAlin.between,
                    drawableEnd: DrawableText(
                      size: 16.0.sp,
                      text: product.price,
                      color: AppColorManager.mainColor,
                    ),
                  ),
                  DrawableText(
                    size: 14.0.sp,
                    text: 'quantity: ${product.quantity}',
                    fontFamily: FontManager.cairoBold,
                    color: Colors.grey,
                    matchParent: true,
                    drawableAlin: DrawableAlin.between,
                    drawableEnd: DrawableText(
                      size: 16.0.sp,
                      text: product.discountPrice,
                      color: AppColorManager.redPrice,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}