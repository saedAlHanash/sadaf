import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_button.dart';
import 'package:sadaf/core/widgets/not_found_widget.dart';
import 'package:sadaf/features/orders/ui/widget/item_order_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../product/ui/widget/item_product.dart';
import '../../bloc/order_by_id_cubit/order_by_id_cubit.dart';
import '../../bloc/orders_cubit/orders_cubit.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: BlocBuilder<OrderByIdCubit, OrderByIdInitial>(
          builder: (context, state) {
            return DrawableText(
              text: '#${state.result.id}',
              size: 28.0.spMin,
            );
          },
        ),
        actions: [
          Center(
            child: BlocBuilder<OrderByIdCubit, OrderByIdInitial>(
              builder: (context, state) {
                return DrawableText(
                  text: state.result.status,
                  padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: MyButton(
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteName.trackingOrder,
            arguments: context.read<OrderByIdCubit>().state.result,
          );
        },
        child: DrawableText(
          text: S.of(context).trackingOrder.toUpperCase(),
          color: AppColorManager.whit,
          fontFamily: FontManager.cairoBold.name,
          drawablePadding: 20.0.w,
          drawableEnd: ImageMultiType(
            url: Icons.map_outlined,
            color: Colors.white,
            height: 30.0.r,
            width: 30.0.r,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<OrderByIdCubit, OrderByIdInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            return Column(
              children: [
                for (var e in state.result.products) ItemOrderProduct(product: e),
                if (state.result.couponCode.isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0).r,
                    child: MyTextFormOutLineWidget(
                      label: S.of(context).coupon_code,
                      innerPadding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                      enable: false,
                      initialValue: state.result.couponCode,
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
                          text: state.result.total,
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
                          text: state.result.subtotal,
                          color: AppColorManager.c50,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.result.statusEnum == OrderStatus.canceled)
                  const _ItemDateOrderRed(state: OrderStatus.canceled),
                if (state.result.statusEnum == OrderStatus.paymentFailed)
                  const _ItemDateOrderRed(state: OrderStatus.paymentFailed),
                if (state.result.statusEnum == OrderStatus.returned)
                  const _ItemDateOrderRed(state: OrderStatus.returned),
                _ItemDateOrder(state: OrderStatus.pending, date: DateTime.now()),
                _ItemDateOrder(state: OrderStatus.processing, date: DateTime.now()),
                _ItemDateOrder(state: OrderStatus.ready, date: DateTime.now()),
                _ItemDateOrder(state: OrderStatus.shipping, date: DateTime.now()),
                _ItemDateOrder(
                  state: OrderStatus.completed,
                ),
                40.0.verticalSpace,
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ItemDateOrder extends StatelessWidget {
  const _ItemDateOrder({required this.state, this.date});

  final OrderStatus state;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      size: 18.0.sp,
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0).r,
      text: state.getNameDateOrderStatus,
      matchParent: true,
      color: date == null ? AppColorManager.lightGrayEd : AppColorManager.mainColor,
      drawableAlin: DrawableAlin.between,
      drawableEnd: DrawableText(
        size: 14.0.sp,
        textAlign: TextAlign.center,
        text: date == null
            ? S.of(context).notYet
            : '${date!.formatDate}\n${date!.formatTime}',
        color: date == null ? AppColorManager.lightGrayEd : AppColorManager.c6e,
      ),
    );
  }
}

class _ItemDateOrderRed extends StatelessWidget {
  const _ItemDateOrderRed({required this.state, this.date});

  final OrderStatus state;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      size: 18.0.sp,
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0).r,
      text: state.getNameDateOrderStatus,
      matchParent: true,
      color: Colors.red,
      drawableAlin: DrawableAlin.between,
      drawableEnd: DrawableText(
        size: 14.0.sp,
        textAlign: TextAlign.center,
        text: date == null
            ? S.of(context).notYet
            : '${date!.formatDate}\n${date!.formatTime}',
        color: Colors.red,
      ),
    );
  }
}
