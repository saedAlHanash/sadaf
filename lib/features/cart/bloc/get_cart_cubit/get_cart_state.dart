part of 'get_cart_cubit.dart';

class CartInitial extends AbstractCubit<Cart> {
  const CartInitial({
    required super.result,
    super.error,
    super.statuses,
  });

  factory CartInitial.initial() {
    return CartInitial(
      result: Cart.fromJson({}),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CartInitial copyWith({
    CubitStatuses? statuses,
    Cart? result,
    String? error,
  }) {
    return CartInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
