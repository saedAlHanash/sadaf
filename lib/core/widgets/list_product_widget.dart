import 'package:flutter/material.dart';
import 'package:sadaf/features/cart/service/cart_service.dart';

import '../../features/cart/ui/widget/item_cart.dart';
import '../../features/product/data/models/product.dart';
import '../../features/product/ui/widget/item_product.dart';
import '../injection/injection_container.dart';

class ListProductWidget extends StatelessWidget {
  const ListProductWidget({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      shrinkWrap: true,
      itemBuilder: (_, i) {
        return ItemProductH(product: products[i]);
      },
    );
  }
}

class ListProductCartWidget extends StatefulWidget {
  const ListProductCartWidget({super.key});

  @override
  State<ListProductCartWidget> createState() => _ListProductCartWidgetState();
}

class _ListProductCartWidgetState extends State<ListProductCartWidget> {
  final List<Product> products = [];

  @override
  void initState() {
    products
      ..clear()
      ..addAll(sl<CartService>().getCartProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      shrinkWrap: true,
      itemBuilder: (_, i) {
        return ItemProductCart(
          product: products[i],
          onRemove: (id) {
            sl<CartService>().removeFromCart(id,context: context);
            setState(
              () => products
                ..clear()
                ..addAll(sl<CartService>().getCartProducts()),
            );
          },
        );
      },
    );
  }
}
