import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/features/cart/service/cart_service.dart';

import '../../features/cart/bloc/get_cart_cubit/get_cart_cubit.dart';
import '../../features/cart/ui/widget/item_cart.dart';
import '../../features/product/data/response/products_response.dart';
import '../../features/product/data/response/products_response.dart';
import '../../features/product/ui/widget/item_product.dart';
import '../injection/injection_container.dart';

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
    return BlocBuilder<CartCubit, CartInitial>(
      builder: (context, state) {
        return ListView.separated(
          itemCount: state.result.products.length,
          shrinkWrap: true,
          itemBuilder: (_, i) {
            return ItemProductCart(
              product: state.result.products[i],
              onRemove: (id) {
                sl<CartService>().removeFromCart(id, context: context);
                setState(
                  () => state.result.products
                    ..clear()
                    ..addAll(sl<CartService>().getCartProducts()),
                );
              },
            );
          },
          separatorBuilder: (_, i) => 20.0.verticalSpace,
        );
      },
    );
  }
}
