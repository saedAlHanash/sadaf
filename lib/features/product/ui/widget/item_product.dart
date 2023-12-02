import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../router/app_router.dart';
import '../../data/response/products_response.dart';

class ItemProduct1 extends StatelessWidget {
  const ItemProduct1({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.product, arguments: Product.fromJson({}));
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
                url: Assets.iconsTemp3,
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
                          size: 20.0.sp,
                          text: 'Dining Chair',
                          fontFamily: FontManager.cairoBold,
                        ),
                        DrawableText(
                          matchParent: true,
                          size: 20.0.sp,
                          fontFamily: FontManager.cairoBold,
                          text: 100000.formatPrice,
                          color: AppColorManager.red,
                        ),
                        DrawableText(
                          matchParent: true,
                          size: 15.0.sp,
                          text: 400000.formatPrice,
                          color: AppColorManager.gray,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 80.0.r,
                        width: 80.0.r,
                        padding: const EdgeInsets.all(10.0).r,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const ImageMultiType(
                          url: Assets.iconsPackage,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemProduct2 extends StatelessWidget {
  const ItemProduct2({super.key});

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

class ItemProduct3 extends StatelessWidget {
  const ItemProduct3({super.key, this.width});

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
        Navigator.pushNamed(context, RouteName.product, arguments: Product.fromJson({}));
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
