import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:sadaf/core/api_manager/api_service.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/snack_bar_message.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../../favorite/data/response/fav_response.dart';
import '../../bloc/select_option_cubit/select_option_cubit.dart';
import '../../data/response/products_response.dart';
import '../pages/product_options_page.dart';

class AddToCartBtn extends StatelessWidget {
  const AddToCartBtn({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToCartCubit, AddToCartInitial>(
      builder: (context, state) {
        return InkWell(
          onTap: state.statuses.loading
              ? null
              : () async {
                  if (product.options.isNotEmpty) {
                    final result = await NoteMessage.showBottomSheet1(
                        context,
                        MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (_) => sl<SelectOptionCubit>()..setProduct(product),
                            ),
                          ],
                          child: ProductOptionsPage(
                            product: product,
                          ),
                        ));
                    if (!result) return;
                  }
                  if (context.mounted) {
                    context.read<AddToCartCubit>().addToCart(productId: product.id);
                  }
                },
          child: Container(
            height: 68.0.h,
            width: 1.0.sw,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColorManager.mainColorLight,
                  AppColorManager.mainColor,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
            child: DrawableText(
              text: S.of(context).add_to_cart,
              matchParent: true,
              color: Colors.white,
              fontFamily: FontManager.cairoBold.name,
              size: 24.0.sp,
              textAlign: TextAlign.center,
              drawableEnd: BlocBuilder<AddToCartCubit, AddToCartInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget(color: Colors.white);
                  }

                  return ImageMultiType(
                    height: 26.0.r,
                    width: 26.0.r,
                    url: state.showDone ? Icons.check : Assets.iconsBag,
                    color: Colors.white,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class AddToCartBtnFav extends StatelessWidget {
  const AddToCartBtnFav({super.key, required this.fav});

  final Fav fav;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToCartCubit, AddToCartInitial>(
      buildWhen: (p, c) => c.id == fav.productId,
      builder: (context, state) {
        return InkWell(
          onTap: state.statuses.loading
              ? null
              : () {
                  loggerObject.w(fav.productId);
                  context.read<AddToCartCubit>().addToCart(productId: fav.productId);
                },
          child: Container(
            height: 30.0.r,
            width: 30.0.r,
            color: Colors.black,
            child: state.statuses.loading
                ? MyStyle.loadingWidget(color: AppColorManager.whit)
                : const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }
}

class AddToCartBag extends StatelessWidget {
  const AddToCartBag({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToCartCubit, AddToCartInitial>(
      builder: (context, state) {
        return GestureDetector(
          onTap: state.statuses.loading
              ? null
              : () async {
                  if (product.options.isNotEmpty) {
                    final result = await NoteMessage.showBottomSheet1(
                        context,
                        MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (_) => sl<SelectOptionCubit>()..setProduct(product),
                            ),
                          ],
                          child: ProductOptionsPage(
                            product: product,
                          ),
                        ));
                    if (!result) return;
                  }
                  if (context.mounted) {
                    context.read<AddToCartCubit>().addToCart(productId: product.id);
                  }
                },
          child: BlocBuilder<AddToCartCubit, AddToCartInitial>(
            buildWhen: (p, c) => c.id == product.id,
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              return Container(
                height: 45.0.r,
                width: 45.0.r,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10.0).r,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: ImageMultiType(
                    url: state.showDone ? Icons.check : Assets.iconsPackage,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
