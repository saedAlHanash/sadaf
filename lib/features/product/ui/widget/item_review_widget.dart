import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:sadaf/features/product/ui/widget/price_screen.dart';
import 'package:sadaf/generated/assets.dart';

class ItemReviewWidget extends StatelessWidget {
  const ItemReviewWidget({super.key});

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
                        url: Assets.iconsAccount,
                      ),
                      16.0.horizontalSpace,
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DrawableText(text: 'Satria Agni'),
                          DrawableText(
                            text: 'Househusband',
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const ReviewWidget(),
                ],
              ),
              DrawableText(
                text: '“I love that I can spend more time with my husband,'
                    ' children, and family, and less time stressing '
                    'over getting my house clean.”',
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0).r,
              ),
            ],
          ),
        ),
        Divider(endIndent: 0, indent: 0),
      ],
    );
  }
}
