part of 'update_cart_cubit.dart';

class UpdateCartInitial  {
  final int result;


  const UpdateCartInitial({
    required this.result,

  });

  factory UpdateCartInitial.initial() {
    return UpdateCartInitial(
      result: 0,
    );
  }

  UpdateCartInitial copyWith({
    int? result,
    bool? goToCart,
  }) {
    return UpdateCartInitial(
      result: result ?? this.result,

    );
  }
}
