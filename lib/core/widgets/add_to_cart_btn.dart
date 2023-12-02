import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/util/my_style.dart';
import 'package:sadaf/core/util/snack_bar_message.dart';

import '../../features/cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../features/cart/service/cart_service.dart';
import '../../features/product/data/response/products_response.dart';
import '../../features/product/data/response/products_response.dart';
import '../../generated/assets.dart';
import '../injection/injection_container.dart';
import 'my_button.dart';

class AddToCartBtn extends StatefulWidget {
  const AddToCartBtn({super.key, required this.product});

  final Product product;

  @override
  State<AddToCartBtn> createState() => _AddToCartBtnState();
}

class _AddToCartBtnState extends State<AddToCartBtn> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return MyStyle.loadingWidget();
    }
    return MyButton(
      onTap: () {
        setState(() => loading = true);
        Future.delayed(
          const Duration(seconds: 1),
          () {
            setState(() => loading = false);
            NoteMessage.showSnakeBar(message: 'تم الاضافة للسلة', context: context);
          },
        );

        sl<CartService>().addToCart(widget.product,context: context);
      },
      width: 70.0.w,
      color: AppColorManager.mainColor,
      child: DrawableText(
        text: 'أضف للسلة',
        padding: const EdgeInsets.symmetric(vertical: 7.0).h,
        size: 12.0.spMin,
        color: Colors.white,
      ),
    );
  }
}

class IconAddToCartWidget extends StatefulWidget {
  const IconAddToCartWidget({super.key, required this.product});

  final Product product;

  @override
  State<IconAddToCartWidget> createState() => _IconAddToCartWidgetState();
}

class _IconAddToCartWidgetState extends State<IconAddToCartWidget> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return MyStyle.loadingWidget();
    }

    return BlocListener<AddToCartCubit, AddToCartInitial>(
      listenWhen: (p, c) => p.result != c.result,
      listener: (_, state) {
        setState(() => loading = true);
        Future.delayed(
          const Duration(seconds: 1),
          () {
            setState(() => loading = false);
            NoteMessage.showSnakeBar(message: 'تم الاضافة للسلة', context: context);
          },
        );
        sl<CartService>().addToCart(widget.product, addQuantity: true,context: context);

      },
      child: InkWell(
        onTap: () {
          setState(() => loading = true);
          Future.delayed(
            const Duration(seconds: 1),
            () {
              setState(() => loading = false);
              NoteMessage.showSnakeBar(message: 'تم الاضافة للسلة', context: context);
            },
          );
          sl<CartService>().addToCart(widget.product, addQuantity: true,context: context);
        },
        child: Container(
          width: 70.0.w,
          height: 40.0.h,
          alignment: Alignment.center,
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.all(10.0).r,
          decoration: BoxDecoration(
              color: AppColorManager.mainColor,
              borderRadius: BorderRadius.circular(200.0)),
          child: const RoundImageWidget(
            url: Assets.iconsCart,
          ),
        ),
      ),
    );
  }
}
