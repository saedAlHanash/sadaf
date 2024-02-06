import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/enum_manager.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../data/response/orders_response.dart';

class ItemOrderWidget extends StatefulWidget {
  const ItemOrderWidget({super.key, required this.order});

  final Order order;

  @override
  State<ItemOrderWidget> createState() => ItemOrderWidgetState();
}

class ItemOrderWidgetState extends State<ItemOrderWidget> {
  // var isExpanded = false;

  void updateExpanded(bool isExpanded) {
    // setState(() => this.isExpanded = !isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30.0).w,
      padding: const EdgeInsets.only(right: 30.0, left: 5.0, top: 15.0).r,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColorManager.black,
            width: 1.0.h,
          ),
        ),
      ),
      child: Column(
        children: [
          DrawableText(
            text: '#${widget.order.id}',
            matchParent: true,
            size: 16.0.sp,
            drawableAlin: DrawableAlin.between,
            drawableEnd: DrawableText(
              text: widget.order.total,
              fontFamily: FontManager.cairoBold.name,
            ),
          ),
          10.0.verticalSpace,
          DrawableText(
            text: widget.order.status,
            matchParent: true,
            color: widget.order.statusEnum.getOrderStateColorText,
            drawableAlin: DrawableAlin.between,
            drawableEnd: DrawableText(
              size: 14.0.sp,
              color: Colors.grey,
              text: DateTime.now().formatDateTime,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemOrderBody extends StatelessWidget {
  const ItemOrderBody({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (order.couponCode.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0).r,
            child: MyTextFormOutLineWidget(
              label: S.of(context).coupon_code,
              innerPadding: const EdgeInsets.symmetric(horizontal: 10.0).w,
              enable: false,
              initialValue: order.couponCode,
            ),
          ),
        20.0.verticalSpace,
        Container(
          color: AppColorManager.f8,
          padding: const EdgeInsets.all(30.0).r,
          child: Column(
            children: [
              DrawableText(
                size: 16.0.sp,
                text: S.of(context).order_summary.toUpperCase(),
                matchParent: true,
                color: AppColorManager.c50,
                drawableAlin: DrawableAlin.between,
                drawableEnd: DrawableText(
                  size: 16.0.sp,
                  text: order.total,
                  color: AppColorManager.c50,
                ),
              ),
              15.0.verticalSpace,
              DrawableText(
                size: 16.0.sp,
                text: S.of(context).additional_service.toUpperCase(),
                matchParent: true,
                color: AppColorManager.c50,
                drawableAlin: DrawableAlin.between,
                drawableEnd: DrawableText(
                  size: 16.0.sp,
                  text: '0',
                  color: AppColorManager.c50,
                ),
              ),
              const Divider(),
              DrawableText(
                size: 20.0.sp,
                text: S.of(context).subtotal.toUpperCase(),
                matchParent: true,
                color: AppColorManager.c50,
                drawableAlin: DrawableAlin.between,
                drawableEnd: DrawableText(
                  size: 20.0.sp,
                  text: order.subtotal,
                  color: AppColorManager.c50,
                ),
              ),
            ],
          ),
        ),
        20.0.verticalSpace,
        Row(
          children: [
            Expanded(child: 0.0.verticalSpace),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  order.statusEnum == OrderStatus.shipping
                      ? RouteName.trackingOrder
                      : RouteName.orderInfo,
                  arguments: order,
                );
              },
              child: DrawableText(
                text: S.of(context).reviewOrder,
                drawableAlin: DrawableAlin.withText,
                drawableEnd: ImageMultiType(url: Icons.arrow_forward_ios),
              ),
            ),
          ],
        )
      ],
    );
  }
}
