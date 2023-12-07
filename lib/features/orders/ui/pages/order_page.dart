import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/not_found_widget.dart';
import 'package:sadaf/features/orders/ui/widget/item_order_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
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
            child: DrawableText(
              text: 'Progress',
              padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
            ),
          )
        ],
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
                10.0.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
                  child: MyTextFormOutLineWidget(
                    label: S.of(context).coupon_code,
                    innerPadding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                    enable: false,
                    initialValue: 'coupon',
                  ),
                ),
                Container(
                  color: AppColorManager.f8,
                  padding: const EdgeInsets.all(30.0).r,
                  child: Column(
                    children: [
                      DrawableText(
                        size: 16.0.sp,
                        text: S.of(context).order_summary.toUpperCase(),
                        matchParent: true,
                        drawableAlin: DrawableAlin.between,
                        drawableEnd: DrawableText(
                          size: 16.0.sp,
                          text: state.result.total,
                          color: AppColorManager.mainColor,
                        ),
                      ),
                      15.0.verticalSpace,
                      DrawableText(
                        size: 16.0.sp,
                        text: S.of(context).additional_service.toUpperCase(),
                        matchParent: true,
                        drawableAlin: DrawableAlin.between,
                        drawableEnd: DrawableText(
                          size: 16.0.sp,
                          text: '0',
                          color: AppColorManager.mainColor,
                        ),
                      ),
                      Divider(),
                      DrawableText(
                        size: 20.0.sp,
                        text: S.of(context).subtotal.toUpperCase(),
                        matchParent: true,
                        drawableAlin: DrawableAlin.between,
                        drawableEnd: DrawableText(
                          size: 20.0.sp,
                          text: state.result.subtotal,
                          color: AppColorManager.mainColor,
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
