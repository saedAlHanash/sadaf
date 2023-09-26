import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/shared_preferences.dart';

import '../../../core/util/pair_class.dart';
import '../../product/data/models/product.dart';
import '../bloc/update_cart_cubit/update_cart_cubit.dart';

class CartService {
  int get getCounts => AppSharedPreference.getJsonListCart().length;

  void addToCart(Product product,
      {bool addQuantity = true, required BuildContext context}) {
    var productFromCart = getProduct(product.id);

    if (productFromCart == null) {
      final list = AppSharedPreference.getJsonListCart();
      list.add(jsonEncode(product.toJson()));
      AppSharedPreference.updateCart(list);
      context.read<UpdateCartCubit>().updateCart();
      return;
    }

    final list = getCartProducts();

    if (addQuantity) {
      productFromCart.first.quantity += product.quantity;

      list[productFromCart.second] = productFromCart.first;
    } else {
      list[productFromCart.second] = product;
    }
    AppSharedPreference.updateCart(_convertToListString(list));
    context.read<UpdateCartCubit>().updateCart();
  }

  List<Product> getCartProducts() {
    final list = AppSharedPreference.getJsonListCart();
    final productList = <Product>[];
    for (var e in list) {
      productList.add(Product.fromJson(jsonDecode(e)));
    }
    return productList;
  }

  List<String> _convertToListString(List<Product> list) {
    return List<String>.from(list.map((e) => jsonEncode(e))).toList();
  }

  num getTotal({List<Product>? list}) {
    num price = 0.0;
    list ??= getCartProducts();
    for (var e in list) {
      price += (e.getOfferPriceNum * e.quantity);
    }
    return price;
  }

  Pair<Product, int>? getProduct(int productId) {
    final list = getCartProducts();
    for (var i = 0; i < list.length; i++) {
      if (list[i].id != productId) continue;
      return Pair(list[i], i);
    }
    return null;
  }

  void removeFromCart(int productId, {required BuildContext context}) {
    final productFromCart = getProduct(productId);
    if (productFromCart == null) return;

    final list = getCartProducts();
    list.removeAt(productFromCart.second);
    AppSharedPreference.updateCart(_convertToListString(list));
    context.read<UpdateCartCubit>().updateCart();
  }

  void cleanCart() {
    AppSharedPreference.updateCart([]);
  }
}
