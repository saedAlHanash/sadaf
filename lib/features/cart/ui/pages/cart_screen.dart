import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/core/widgets/list_product_widget.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';
import 'package:sadaf/features/cart/service/cart_service.dart';
import 'package:sadaf/features/cart/ui/pages/done_create_order_page.dart';
import 'package:sadaf/router/app_router.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../generated/l10n.dart';
import '../../../orders/data/request/create_order_request.dart';
import '../../bloc/cart_cubut/cart_cubit.dart';
import '../../bloc/coupon_cubit/coupon_cubit.dart';
import '../../bloc/create_order_cubit/create_order_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final request = CreateOrderRequest();

  @override
  void initState() {
    context.read<CouponCubit>().reInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CartCubit, CartInitial>(
          listener: (context, state) {
            final count = sl<CartService>().getCounts;
            if (count == 0) setState(() {});
          },
        ),
        BlocListener<CreateOrderCubit, CreateOrderInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const DoneCreateOrderPage();
                },
              ),
            );
            setState(() {});
          },
        ),
      ],
      child: Column(
        children: [
          AppBarWidget(titleText: S.of(context).cart),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 0.48.sh,
                    child: const ListProductCartWidget(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
                    child: BlocBuilder<CouponCubit, CouponInitial>(
                      builder: (context, state) {
                        return MyTextFormOutLineWidget(
                          label: S.of(context).coupon_code,
                          innerPadding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                          enable: state.statuses == CubitStatuses.init,
                          onChanged: (val) => request.couponCode = val,
                          iconWidgetLift: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0).r,
                            child: SizedBox(
                              width: 74.0.w,
                              child: TextButton(
                                onPressed: () {},
                                child: DrawableText(
                                  text: S.of(context).apply,
                                  size: 11.0.sp,
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(AppColorManager.ee)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  BlocBuilder<CartCubit, CartInitial>(
                    builder: (context, state) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0).r,
                        color: AppColorManager.f8,
                        child: Column(
                          children: [
                            ItemUnderLine(
                              title: S.of(context).order_summary.toUpperCase(),
                              data: state.subTotal.formatPrice,
                            ),
                            ItemUnderLine(
                              title: S.of(context).additional_service.toUpperCase(),
                              data: state.deliveryPrice.formatPrice,
                            ),
                            Divider(),
                            ItemUnderLine(
                              title: S.of(context).subtotal.toUpperCase(),
                              data: (state.total).formatPrice,
                              large: true,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  20.0.verticalSpace,
                  BlocConsumer<CreateOrderCubit, CreateOrderInitial>(
                    listenWhen: (p, c) => c.statuses.done,
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state.statuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return MyButton(
                        onTap: () {
                          context
                              .read<CreateOrderCubit>()
                              .createOrder(context, request: request);
                        },
                        text: S.of(context).continueTo,
                      );
                    },
                  ),
                  20.0.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemUnderLine extends StatelessWidget {
  const ItemUnderLine(
      {super.key, required this.title, required this.data, this.large = false});

  final String title;
  final String data;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: title,
      matchParent: true,
      color: Colors.grey,
      drawableAlin: DrawableAlin.between,
      size: large ? 20.0.sp : null,
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 9.0).r,
      drawableEnd: DrawableText(
        text: data,
        size: large ? 20.0.sp : null,
      ),
    );
  }
}
