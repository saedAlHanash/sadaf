part of 'add_to_cart_cubit.dart';

class AddToCartInitial extends AbstractCubit<bool> {
  final int id;
  final bool goToCart;
  final bool showDone;

  const AddToCartInitial({
    required super.result,
    super.statuses,
    super.error,
    required this.id,
    required this.goToCart,
    required this.showDone,
  });

  factory AddToCartInitial.initial() {
    return const AddToCartInitial(
      result: false,
      id: 0,
      goToCart: false,
      showDone: false,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, showDone, goToCart];

  AddToCartInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    bool? goToCart,
    bool? showDone,
    int? id,
  }) {
    return AddToCartInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      goToCart: goToCart ?? this.goToCart,
      showDone: showDone ?? this.showDone,
    );
  }
}
