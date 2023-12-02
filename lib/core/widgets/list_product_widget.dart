import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/features/cart/service/cart_service.dart';

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
  final List<Product> products = [
    Product.fromJson({}),
    Product.fromJson({}),
    Product.fromJson({}),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      shrinkWrap: true,
      itemBuilder: (_, i) {
        return ItemProductCart(
          product: products[i],
          onRemove: (id) {
            sl<CartService>().removeFromCart(id, context: context);
            setState(
              () => products
                ..clear()
                ..addAll(sl<CartService>().getCartProducts()),
            );
          },
        );
      },
      separatorBuilder: (_, i) => 20.0.verticalSpace,
    );
  }
}
