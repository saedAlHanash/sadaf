import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';


import '../../features/cart/bloc/get_cart_cubit/get_cart_cubit.dart';
import '../../features/cart/ui/widget/item_cart.dart';
import '../../features/product/data/response/products_response.dart';
import '../../features/product/data/response/products_response.dart';
import '../../features/product/ui/widget/item_product.dart';
import '../injection/injection_container.dart';
import '../util/my_style.dart';

class ListProductCartWidget extends StatefulWidget {
  const ListProductCartWidget({super.key});

  @override
  State<ListProductCartWidget> createState() => _ListProductCartWidgetState();
}

class _ListProductCartWidgetState extends State<ListProductCartWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.48.sh,
      child: BlocBuilder<CartCubit, CartInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<CartCubit>().getCart();
            },
            child: ListView.separated(
              itemCount: state.result.products.length,
              shrinkWrap: true,
              itemBuilder: (_, i) {
                return ItemProductCart(
                  product: state.result.products[i],
                );
              },
              separatorBuilder: (_, i) => 20.0.verticalSpace,
            ),
          );
        },
      ),
    );
  }
}
