import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/card_slider_widget.dart';
import 'package:sadaf/features/product/ui/widget/add_to_cart_widget.dart';
import 'package:sadaf/features/product/ui/widget/amount_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../cart/bloc/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../bloc/product_by_id_cubit/product_by_id_cubit.dart';
import '../widget/item_product.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: 'تفاصيل المنتج',
        actions: [
          IconButton(
            onPressed: () {
              context.read<AddToCartCubit>().goToCart(true);
              while (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductByIdCubit, ProductByIdInitial>(
        builder: (_, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final product = state.result.product;
          final suggestions = state.result.suggestions;
          return SingleChildScrollView(
            child: Column(
              children: [
                CardImageSlider(
                  images: product.cover,
                  height: 300.0.h,
                ),
                20.0.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DrawableText(
                              text: product.name,
                            ),
                            10.0.verticalSpace,
                            DrawableText(text: 'براند - ${product.brand.name}'),
                          ],
                        ),
                      ),
                    ),
                    AmountWidget(
                      product: product,
                      onChange: (amount) => product.quantity = amount,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                  child: Column(
                    children: [
                      30.0.verticalSpace,
                      DrawableText.titleList(text: 'الوصف'),
                      DrawableText(
                        matchParent: true,
                        textAlign: TextAlign.start,
                        padding: const EdgeInsets.all(7.0).r,
                        text: product.description,
                      ),
                      10.0.verticalSpace,
                      AddToCartWidget(product: product),
                      DrawableText.titleList(
                        text: 'اقتراحات ذات صله',
                        padding: const EdgeInsets.symmetric(vertical: 15.0).h,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: MyStyle.productGridDelegate,
                        itemCount: suggestions.length,
                        itemBuilder: (_, i) {
                          final item = suggestions[i];
                          return ItemProduct(product: item);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
