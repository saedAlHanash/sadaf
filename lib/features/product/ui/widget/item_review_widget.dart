import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/features/product/ui/pages/price_screen.dart';

import '../../data/response/products_response.dart';

class ItemReviewWidget extends StatelessWidget {
  const ItemReviewWidget({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          horizontalTitleGap: 0,
          contentPadding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0).r,
          title: DrawableText(text: review.user.name),
          leading: CircleImageWidget(url: review.user.avatar),
          subtitle: DrawableText(
            text: 'review.comment',
            maxLines: 1,
            size: 12.0.sp,
            color: Colors.grey,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ReviewWidget(rate: 3),
              DrawableText(
                text: review.createdAt?.formatDate ?? '',
                color: Colors.grey,
              ),
            ],
          ),
        ),
        const Divider(height: 0, endIndent: 0, indent: 0),
      ],
    );
  }
}
