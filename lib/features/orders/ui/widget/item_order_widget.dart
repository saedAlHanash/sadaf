import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:sadaf/core/util/snack_bar_message.dart';
import 'package:sadaf/core/widgets/my_card_widget.dart';
import 'package:sadaf/features/product/ui/widget/item_product.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../generated/assets.dart';
import '../../data/response/my_orders.dart';

class ItemOrderWidget extends StatelessWidget {
  const ItemOrderWidget({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyCardWidget(
          cardColor: AppColorManager.f6,
          elevation: 0.0,
          padding: const EdgeInsets.all(7.0).r,
          margin: const EdgeInsets.symmetric(horizontal: 15.0).r,
          child: SizedBox(
            height: 150.0.h,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DrawableText(
                        fontFamily: FontManager.cairoBold,
                        text: 'التاريخ: ${order.createdAt}',
                        matchParent: true,
                        drawableStart: IconButton(
                          onPressed: () {
                            final listProduct =
                                order.details.map((e) => e.product).toList();
                            NoteMessage.showBottomSheet(
                                context,
                                Container(
                                  constraints: BoxConstraints(maxHeight: .5.sh),
                                  child: ListView.builder(
                                    itemCount: listProduct.length,
                                    itemBuilder: (_, i) {
                                      return 0.0.verticalSpace;
                                    },
                                  ),
                                ));
                          },
                          icon: const Icon(
                            Icons.info_outline,
                            color: AppColorManager.mainColor,
                          ),
                        ),
                      ),
                      DrawableText(text: 'إجمالي المبلغ: ${order.totalPrice}'),
                      DrawableText(text: 'عدد المنتجات: ${order.details.length}'),
                      DrawableText(text: 'ملاحظات: ${order.note}'),
                      DrawableText(text: 'حالة الطلب: ${order.status}'),
                    ],
                  ),
                ),
                RoundImageWidget(
                  url: order.details.firstOrNull?.product.thumbnail ?? Assets.iconsLogo,
                  height: 140.0.r,
                  width: 140.0.r,
                ),
              ],
            ),
          ),
        ),
        DrawableText(
          text: 'حالة الطلب:',
          matchParent: true,
          textAlign: TextAlign.start,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
          drawableAlin: DrawableAlin.withText,
          drawablePadding: 5.0.w,
          drawableEnd: DrawableText(
            text: order.status,
            fontFamily: FontManager.cairoBold,
          ),
        )
      ],
    );
  }
}
