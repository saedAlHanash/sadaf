import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/snack_bar_message.dart';
import 'package:sadaf/core/widgets/my_checkbox_widget.dart';
import 'package:sadaf/core/widgets/not_found_widget.dart';
import 'package:sadaf/features/cart/bloc/get_cart_cubit/get_cart_cubit.dart';
import 'package:sadaf/features/cart/ui/pages/done_create_order_page.dart';
import 'package:sadaf/features/cart/ui/widget/coupon_widget.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../cart/bloc/create_order_cubit/create_order_cubit.dart';
import '../../bloc/remove_from_cart_cubit/remove_from_cart_cubit.dart';
import '../widget/item_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateOrderCubit, CreateOrderInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) async {
            switch (state.paymentMethod) {
              case PaymentMethod.cash:
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const DoneCreateOrderPage()));
                break;
              case PaymentMethod.ePay:
                Navigator.pushNamed(context, RouteName.webView,
                    arguments: state.paymentUrl);
                break;
            }
          },
        ),
        BlocListener<RemoveFromCartCubit, RemoveFromCartInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<CartCubit>().getCart();
          },
        ),
      ],
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<CartCubit>().getCart();
        },
        child: BlocBuilder<CartCubit, CartInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            if (state.result.products.isEmpty) {
              return NotFoundWidget(
                text: S.of(context).emptyCart,
                icon: Assets.iconsNoCartResult,
              );
            }
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  for (var e in state.result.products) ItemProductCart(product: e),
                  20.0.verticalSpace,
                  const CouponWidget(),
                  const _CreateOrderBtn(),
                  20.0.verticalSpace,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CreateOrderBtn extends StatefulWidget {
  const _CreateOrderBtn();

  @override
  State<_CreateOrderBtn> createState() => _CreateOrderBtnState();
}

class _CreateOrderBtnState extends State<_CreateOrderBtn> {
  var paymentMethod = PaymentMethod.cash;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyCheckboxWidget(
          isRadio: true,
          items: PaymentMethod.values.getSpinnerItems(
            selectedId: paymentMethod.index,
          ),
          onSelected: (value, _, __) => paymentMethod = value.item,
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
              onTap: () async {
                NoteMessage.showBottomSheet1(context, const _ConfirmAddress()).then(
                  (value) {
                    if (!value) return;
                    context.read<CreateOrderCubit>().createOrder(method: paymentMethod);
                  },
                );
              },
              text: S.of(context).continueTo,
            );
          },
        ),
      ],
    );
  }
}

class _ConfirmAddress extends StatelessWidget {
  const _ConfirmAddress();

  @override
  Widget build(BuildContext context) {
    final user = AppSharedPreference.getProfile;
    return Padding(
      padding: const EdgeInsets.all(30.0).r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DrawableText(text: S.of(context).confirm_address),
          10.0.verticalSpace,
          MyTextFormOutLineWidget(
            initialValue: user.governor.name,
            enable: false,
            label: S.of(context).governor,
          ),
          MyTextFormOutLineWidget(
            initialValue: user.address,
            enable: false,
            label: S.of(context).yourAddress,
          ),
          MyTextFormOutLineWidget(
            enable: false,
            label: S.of(context).receiverPhone,
            initialValue: user.receiverPhone.replaceAll('+964', ''),
          ),
          MyTextFormOutLineWidget(
            initialValue: user.mapAddress.toString(),
            label: S.of(context).location,
            enable: false,
          ),
          10.0.verticalSpace,
          Row(
            children: [
              Expanded(
                child: MyButton(
                  color: AppColorManager.mainColorLight,
                  child: DrawableText(
                    color: Colors.white,
                    drawablePadding: 10.0.w,
                    text: S.of(context).update,
                    drawableEnd: const ImageMultiType(
                      url: Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context, false);
                    Navigator.pushNamed(context, RouteName.update,
                        arguments: UpdateType.address);
                  },
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyButton(
                  color: AppColorManager.mainColor,
                  child: DrawableText(
                    drawablePadding: 10.0.w,
                    color: Colors.white,
                    text: S.of(context).confirm,
                    drawableEnd: const ImageMultiType(
                      url: Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    if (user.mapAddress.latitude == 0 || user.address.isEmpty) {
                      NoteMessage.showErrorDialog(context,
                              text: S.of(context).pleasSetYourAddress)
                          .then(
                        (value) {
                          Navigator.pop(context, false);
                          Navigator.pushNamed(context, RouteName.update,
                              arguments: UpdateType.address);
                        },
                      );
                      return;
                    }
                    Navigator.pop(context, true);
                  },
                ),
              ),
            ],
          ),
          50.0.verticalSpace,
        ],
      ),
    );
  }
}
