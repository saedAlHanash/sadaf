part of 'add_to_cart_cubit.dart';

class AddToCartInitial  {
  final int result;
  final bool goToCart;

  const AddToCartInitial({
    required this.result,
    required this.goToCart,
  });

  factory AddToCartInitial.initial() {
    return const AddToCartInitial(
      result: 0,
      goToCart: false,
    );
  }

  AddToCartInitial copyWith({
    int? result,
    bool? goToCart,
  }) {
    return AddToCartInitial(
      result: result ?? this.result,
      goToCart: goToCart ?? this.goToCart,
    );
  }
}
