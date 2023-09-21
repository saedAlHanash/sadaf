part of 'cart_cubit.dart';

class CartInitial {
  final num subTotal;
  final num deliveryPrice;
  final num total;

  const CartInitial({
    required this.subTotal,
    required this.deliveryPrice,
    required this.total,
  });

  factory CartInitial.initial() {
    return const CartInitial(
      subTotal:0,
      deliveryPrice: 0,
      total: 0,
    );
  }

  CartInitial copyWith({
    num? subTotal,
    num? deliveryPrice,
    num? total,
  }) {
    return CartInitial(
      subTotal: subTotal ?? this.subTotal,
      deliveryPrice: deliveryPrice ?? this.deliveryPrice,
      total: total ?? this.total,
    );
  }
}
