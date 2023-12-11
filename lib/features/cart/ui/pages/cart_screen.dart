import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/strings/enum_manager.dart';
import 'package:sadaf/core/widgets/list_product_widget.dart';
import 'package:sadaf/core/widgets/my_text_form_widget.dart';
import 'package:sadaf/core/widgets/not_found_widget.dart';
import 'package:sadaf/features/cart/bloc/get_cart_cubit/get_cart_cubit.dart';
import 'package:sadaf/features/cart/ui/pages/done_create_order_page.dart';
import 'package:sadaf/features/cart/ui/widget/coupon_widget.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../generated/l10n.dart';
import '../../../orders/bloc/create_order_cubit/create_order_cubit.dart';
import '../../../orders/data/request/create_order_request.dart';
import '../../bloc/coupon_cubit/coupon_cubit.dart';
import '../../bloc/remove_from_cart_cubit/remove_from_cart_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final request = CreateOrderRequest();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
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
        BlocListener<RemoveFromCartCubit, RemoveFromCartInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<CartCubit>().getCart();
          },
        ),
      ],
      child: Column(
        children: [
          AppBarWidget(titleText: S.of(context).cart),
          Expanded(
            child: BlocBuilder<CartCubit, CartInitial>(
              builder: (context, state) {
                if (state.result.products.isEmpty) {
                  return const NotFoundWidget(text: 'No Data', icon: Assets.iconsCart);
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const ListProductCartWidget(),
                      const CouponWidget(),
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
                              context.read<CreateOrderCubit>().createOrder();
                            },
                            text: S.of(context).continueTo,
                          );
                        },
                      ),
                      20.0.verticalSpace,
                    ],
                  ),
                );
              },
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
