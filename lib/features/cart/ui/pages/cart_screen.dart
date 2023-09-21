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
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../../settings/services/setting_service.dart';
import '../../bloc/cart_cubut/cart_cubit.dart';
import '../../bloc/coupon_cubit/coupon_cubit.dart';
import '../../bloc/create_order_cubit/create_order_cubit.dart';
import '../../../orders/data/request/create_order_request.dart';

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
    final list = sl<CartService>().getCartProducts();

    if (list.isEmpty) {
      return const NotFoundWidget(
        icon: Assets.iconsNoCart,
        text: 'لا يوجد أي منتجات ف السلة',
      );
    }

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 0.48.sh,
              child: const ListProductCartWidget(),
            ),
            10.0.verticalSpace,
            BlocBuilder<CartCubit, CartInitial>(
              builder: (context, state) {
                return Column(
                  children: [
                    ItemUnderLine(
                      title: 'المجموع',
                      data: state.subTotal.formatPrice,
                    ),
                    ItemUnderLine(
                      title: 'سعر التوصيل',
                      data: state.deliveryPrice.formatPrice,
                    ),
                    ItemUnderLine(
                      title: 'إجمالي المبلغ',
                      data: (state.total).formatPrice,
                    ),
                  ],
                );
              },
            ),
            MyEditTextWidget(
              hint: 'ملاحظاتك',
              backgroundColor: AppColorManager.f6,
              innerPadding: const EdgeInsets.symmetric(horizontal: 10.0).w,
            ),
            BlocBuilder<CouponCubit, CouponInitial>(
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                      child: Row(
                        children: [
                          Expanded(
                            child: MyEditTextWidget(
                              hint: 'اكتب الكوبون',
                              backgroundColor: AppColorManager.f6,
                              innerPadding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                              enable: state.statuses == CubitStatuses.init,
                              onChanged: (val) => request.couponCode = val,
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              if (state.statuses.loading) {
                                return MyStyle.loadingWidget();
                              }
                              return IconButton(
                                onPressed: () {
                                  if (state.statuses != CubitStatuses.init) {
                                    request.couponCode = '';
                                    context.read<CouponCubit>().reInit();
                                  } else {
                                    context.read<CouponCubit>().checkCoupon(
                                          context,
                                          couponCode: request.couponCode,
                                          total: context.read<CartCubit>().state.total,
                                        );
                                  }
                                },
                                icon: Icon(
                                  state.statuses == CubitStatuses.init
                                      ? Icons.send_rounded
                                      : Icons.edit,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                          if (state.statuses.done)
                            Column(
                              children: [
                                ItemUnderLine(
                                  title: 'الخصم ',
                                  data: state.result.offer,
                                ),
                                ItemUnderLine(
                                  title: ' إجمالي المبلغ بعد الخصم',
                                  data: (state.result.totalPrice).formatPrice,
                                ),
                              ],
                            ),
                  ],
                );
              },
            ),
            20.0.verticalSpace,
            if (!AppSharedPreference.isLogin)
              MyButton(
                text: 'تسجيل الدخول للمتابعة',
                onTap: () {
                  Navigator.pushNamed(context, RouteName.login);
                },
              ),
            if (AppSharedPreference.isLogin)
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
                    text: 'متابعة الشراء',
                  );
                },
              ),
            20.0.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class ItemUnderLine extends StatelessWidget {
  const ItemUnderLine({super.key, required this.title, required this.data});

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawableText(
          text: title,
          matchParent: true,
          fontFamily: FontManager.cairoBold,
          drawableAlin: DrawableAlin.between,
          padding: const EdgeInsets.symmetric(horizontal: 40.0).w,
          drawableEnd: DrawableText(
            text: data,
          ),
        ),
        Divider(
          height: 5.0.h,
          thickness: 3.0.r,
          color: AppColorManager.f6,
        ),
        10.0.verticalSpace,
      ],
    );
  }
}
