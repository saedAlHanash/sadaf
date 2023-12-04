import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/product/ui/widget/price_screen.dart';

import '../../data/response/products_response.dart';

class ItemReviewWidget extends StatelessWidget {
  const ItemReviewWidget({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleImageWidget(
                        size: 55.0.r,
                        url: review.user.avatar,
                      ),
                      16.0.horizontalSpace,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DrawableText(text: review.user.name),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const ReviewWidget(),
                      DrawableText(text: review.createdAt?.formatDateTime ?? ''),
                    ],
                  ),
                ],
              ),
              DrawableText(
                text: review.comment,
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0).r,
              ),
            ],
          ),
        ),
        const Divider(endIndent: 0, indent: 0),
      ],
    );
  }
}
