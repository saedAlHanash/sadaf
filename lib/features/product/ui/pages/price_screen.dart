import 'dart:async';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/features/product/ui/widget/related_product_widget.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/product_by_id_cubit/product_by_id_cubit.dart';
import '../widget/amount_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PriceScreen extends StatelessWidget {
  const PriceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
      child: BlocBuilder<ProductByIdCubit, ProductByIdInitial>(
        builder: (context, state) {
          final product = state.result;
          return Column(
            children: [
              10.0.verticalSpace,
              DrawableText(
                text: product.name,
                size: 24.0.sp,
                matchParent: true,
              ),
              7.0.verticalSpace,
              LargeReviewWidget(rating: product.rating),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColorManager.f1),
                ),
                padding: const EdgeInsets.all(12.0).r,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          DrawableText(
                            text: product.price,
                            size: 24.0.sp,
                            color: AppColorManager.black,
                            matchParent: true,
                          ),
                          DrawableText(
                            text: product.discountPrice,
                            size: 14.0.sp,
                            color: AppColorManager.redPrice,
                            matchParent: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              26.0.verticalSpace,
              if (product.discountEndAt != null)
                ProductDateWidget(
                  dateTime:  product.discountEndAt!,
                ),
              26.0.verticalSpace,
              const RelatedProductWidget(),
            ],
          );
        },
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key, required this.rate});

  final num rate;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rate.toDouble(),
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 13.0.r,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0).w,
      itemBuilder: (__, _) {
        return const Icon(Icons.star, color: Colors.black);
      },
      onRatingUpdate: (value) {},
      ignoreGestures: true,
    );
  }
}

class LargeReviewWidget extends StatelessWidget {
  const LargeReviewWidget({super.key, required this.rating});

  final num rating;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: '${rating.toDouble()}',
      size: 12.0.sp,
      padding: const EdgeInsets.symmetric(vertical: 20.0).h,
      matchParent: true,
      drawableAlin: DrawableAlin.withText,
      drawablePadding: 7.0.w,
      drawableStart: RatingBar.builder(
        initialRating: rating.toDouble(),
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 17.0.r,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0).w,
        itemBuilder: (__, _) {
          return const Icon(Icons.star, color: Colors.black);
        },
        onRatingUpdate: (value) {},
        ignoreGestures: true,
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

class ProductDateWidget extends StatefulWidget {
  const ProductDateWidget({super.key, required this.dateTime});

  final DateTime dateTime;

  @override
  State<ProductDateWidget> createState() => _ProductDateWidgetState();
}

class _ProductDateWidgetState extends State<ProductDateWidget> {
  Timer? _timer;

  String d = '-';
  String h = '-';
  String m = '-';
  String s = '-';

  @override
  void initState() {
    setTimes();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => setTimes());
    });
    super.initState();
  }

  void setTimes() {
    final f = widget.dateTime.getFormat(serverDate: serverDateTime);

    d = ((f.months * 30) + f.days).toString();
    h = (f.hours).toString();
    m = (f.minutes).toString();
    s = (f.seconds).toString();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
                    text: d,
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
                    text: h.toString(),
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
                    text: m.toString(),
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
                    text: s.toString(),
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
