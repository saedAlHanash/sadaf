import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/features/product/ui/widget/options_widget.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/select_option_cubit/select_option_cubit.dart';
import '../../data/response/products_response.dart';

class ProductOptionsPage extends StatelessWidget {
  const ProductOptionsPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          .1.sw.verticalSpace,
          SizedBox(
            height: 250.0.h,
            width: .9.sw,
            child: BlocBuilder<SelectOptionCubit, SelectOptionInitial>(
              builder: (context, state) {
                return ImageMultiType(url: state.image, fit: BoxFit.fill);
              },
            ),
          ),
          10.0.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
            child: Column(
              children: [
                BlocBuilder<SelectOptionCubit, SelectOptionInitial>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        DrawableText(
                          text: state.option?.price ?? product.price,
                          size: 24.0.sp,
                          color: AppColorManager.black,
                          matchParent: true,
                        ),
                        DrawableText(
                          text: state.option?.discountPrice ?? product.discountPrice,
                          size: 14.0.sp,
                          color: AppColorManager.redPrice,
                          matchParent: true,
                        ),
                      ],
                    );
                  },
                ),
                30.0.verticalSpace,
                Builder(
                  builder: (context) {
                    final sizes = product.groupedOptions.entries
                        .map((e) => e.key)
                        .toList()
                      ..removeWhere((element) => element.isEmpty);
                    if (sizes.isEmpty) return 0.0.verticalSpace;
                    return Column(
                      children: [
                        DrawableText(text: S.of(context).sizes, matchParent: true),
                        10.0.verticalSpace,
                        SizeOptions(
                          options: sizes,
                        ),
                      ],
                    );
                  },
                ),
                30.0.verticalSpace,
                Builder(
                  builder: (context) {
                    final colors = product.groupedColors.entries
                        .map((e) => e.key)
                        .toList()
                      ..removeWhere((element) => element.isEmpty);
                    if (colors.isEmpty) return 0.0.verticalSpace;
                    return Column(
                      children: [
                        DrawableText(text: S.of(context).colors, matchParent: true),
                        10.0.verticalSpace,
                        ColorOptions(
                          colors: colors,
                        ),
                      ],
                    );
                  },
                ),
                30.0.verticalSpace,
                MyButton(
                  text: S.of(context).continueTo,
                  onTap: () => Navigator.pop(context, true),
                ),
                20.0.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key, required this.rate});

  final num rate;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: '$rate/5 review',
      size: 12.0.sp,
      drawableAlin: DrawableAlin.withText,
      drawablePadding: 7.0.w,
      drawableStart: ImageMultiType(
        url: Icons.star,
        color: Colors.black,
        height: 15.0.r,
        width: 15.0.r,
      ),
    );
  }
}

class ColorsProductWidget extends StatelessWidget {
  const ColorsProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.5).w,
          height: 19.0.r,
          width: 19.0.r,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            shape: BoxShape.circle,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2.5).w,
            height: 15.0.r,
            width: 15.0.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.5).w,
          height: 15.0.r,
          width: 15.0.r,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.amber,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.5).w,
          height: 15.0.r,
          width: 15.0.r,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

class ProductDateWidget extends StatelessWidget {
  const ProductDateWidget({super.key, required this.dateTime});

  final FormatDateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.0.h,
      width: 1.0.sw,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DrawableText(
                    text: S.of(context).days.toUpperCase(),
                    size: 9.0.sp,
                  ),
                  DrawableText(
                    text: dateTime.days.toString(),
                    size: 24.0.sp,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DrawableText(
                    text: S.of(context).hours.toUpperCase(),
                    size: 9.0.sp,
                  ),
                  DrawableText(
                    text: dateTime.hours.toString(),
                    size: 24.0.sp,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DrawableText(
                    text: S.of(context).minutes.toUpperCase(),
                    size: 9.0.sp,
                  ),
                  DrawableText(
                    text: dateTime.minutes.toString(),
                    size: 24.0.sp,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DrawableText(
                    text: S.of(context).seconds.toUpperCase(),
                    size: 9.0.sp,
                  ),
                  DrawableText(
                    text: dateTime.seconds.toString(),
                    size: 24.0.sp,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            height: 1.0.h,
            width: 1.0.sw,
            bottom: 17.0.h,
            child: Container(
              color: Colors.white,
              height: 2.0.h,
              width: 1.0.sw,
            ),
          )
        ],
      ),
    );
  }
}
