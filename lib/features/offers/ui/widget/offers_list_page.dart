import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/features/product/data/response/products_response.dart';
import 'package:sadaf/features/product/ui/widget/price_screen.dart';

import '../../../../generated/assets.dart';
import '../../../product/ui/widget/item_product.dart';

class OfferListPage extends StatelessWidget {
  const OfferListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 30.0).r,
      separatorBuilder: (_, i) {
        return 20.0.verticalSpace;
      },
      itemBuilder: (_, i) {
        return Row(
          children: [
            if (i == 0)
              Column(
                children: [
                  ImageMultiType(
                    url: Assets.iconsSummerSell,
                    height: 51.0.r,
                    width: 103.0.r,
                  ),
                  15.0.verticalSpace,
                  ItemProductOffer(),
                ],
              )
            else
              ItemProductOffer(),
            35.0.horizontalSpace,
            Transform.translate(
              offset: Offset(0, -45.h),
              child: ItemProductOffer(),
            ),
          ],
        );
      },
    );
  }
}
