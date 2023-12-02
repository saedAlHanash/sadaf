import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/features/product/ui/widget/item_product.dart';

import '../../../../generated/l10n.dart';

class RelatedProductWidget extends StatelessWidget {
  const RelatedProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        40.0.verticalSpace,
        MyButton(
          text: S.of(context).add_to_cart,
          onTap: () {},
        ),
        28.0.verticalSpace,
        DrawableText(
          text: S.of(context).related_products,
          size: 18.0.sp,
          fontFamily: FontManager.cairo,
          matchParent: true,
        ),
        SizedBox(
          height: 250.0.h,
          width: 1.0.sw,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, i) => 20.0.horizontalSpace,
            itemBuilder: (_, i) {
              return const ItemProduct3();
            },
          ),
        )
      ],
    );
  }
}
