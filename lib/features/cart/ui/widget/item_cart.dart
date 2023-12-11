import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import 'package:sadaf/features/cart/service/cart_service.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/image_with_fav.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/assets.dart';
import '../../../home/ui/widget/screens/home_screen.dart';
import '../../../product/data/response/products_response.dart';
import '../../../product/data/response/products_response.dart';
import '../../bloc/decrease_cubit/decrease_cubit.dart';
import '../../bloc/increase_cubit/increase_cubit.dart';
import '../../bloc/remove_from_cart_cubit/remove_from_cart_cubit.dart';

class ItemProductCart extends StatelessWidget {
  const ItemProductCart({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorManager.f8,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0).r,
      child: SizedBox(
        height: 95.0.h,
        child: Row(
          children: [
            ImageMultiType(
              url: Assets.iconsTemp5,
              width: 80.0.r,
              height: 80.0.r,
            ),
            8.0.horizontalSpace,
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DrawableText(
                          text: product.name,
                          maxLines: 1,
                          matchParent: true,
                        ),
                        DrawableText(
                          text: product.price,
                          color: AppColorManager.black,
                          matchParent: true,
                          drawablePadding: 10.0.w,
                          drawableAlin: DrawableAlin.withText,
                          drawableEnd: DrawableText(
                            text: product.discountPrice,
                            color: AppColorManager.redPrice,
                            size: 12.0.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BlocBuilder<RemoveFromCartCubit, RemoveFromCartInitial>(
                        buildWhen: (p, c) => c.id == product.id,
                        builder: (context, state) {
                          if (state.statuses.loading) {
                            return MyStyle.loadingWidget();
                          }
                          return InkWell(
                            onTap: () {
                              context
                                  .read<RemoveFromCartCubit>()
                                  .removeFromCart(productId: product.id);
                            },
                            child: const ImageMultiType(
                              url: Icons.cancel_outlined,
                              color: AppColorManager.red,
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: AmountWidgetCart(
                            product: product,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AmountWidgetCart extends StatefulWidget {
  const AmountWidgetCart({super.key, required this.product});

  final Product product;

  @override
  State<AmountWidgetCart> createState() => _AmountWidgetCartState();
}

class _AmountWidgetCartState extends State<AmountWidgetCart> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DecreaseCubit, DecreaseInitial>(
          listenWhen: (p, c) => c.statuses.done && c.id == widget.product.id,
          listener: (context, state) => setState(() => widget.product.quantity--),
        ),
        BlocListener<IncreaseCubit, IncreaseInitial>(
          listenWhen: (p, c) => c.statuses.done && c.id == widget.product.id,
          listener: (context, state) => setState(() => widget.product.quantity++),
        ),
      ],
      child: SizedBox(
        width: 95.0.w,
        height: 26.0.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<IncreaseCubit, IncreaseInitial>(
              buildWhen: (p, c) => c.id == widget.product.id,
              builder: (context, state) {
                return Container(
                  height: 25.0.r,
                  width: 25.0.r,
                  alignment: Alignment.center,
                  color: AppColorManager.black,
                  child: InkWell(
                    onTap: () {
                      context
                          .read<IncreaseCubit>()
                          .increase(productId: widget.product.id);
                    },
                    child: state.statuses.loading
                        ? MyStyle.loadingWidget(color: Colors.white)
                        : Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18.0.r,
                          ),
                  ),
                );
              },
            ),
            DrawableText(
              text: widget.product.quantity.toString(),
              color: Colors.black,
            ),
            BlocBuilder<DecreaseCubit, DecreaseInitial>(
              buildWhen: (p, c) => c.id == widget.product.id,
              builder: (context, state) {
                return Container(
                  height: 25.0.r,
                  width: 25.0.r,
                  alignment: Alignment.center,
                  color: AppColorManager.black,
                  child: InkWell(
                    onTap: () {
                      if (widget.product.quantity <= 1) return;
                      context
                          .read<DecreaseCubit>()
                          .decrease(productId: widget.product.id);
                    },
                    child: state.statuses.loading
                        ? MyStyle.loadingWidget(color: Colors.white)
                        : Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 18.0.r,
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
