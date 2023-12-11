part of 'decrease_cubit.dart';

class DecreaseInitial extends AbstractCubit<bool> {
  final int id;
  final bool goToCart;
  final bool showDone;

  const DecreaseInitial({
    required super.result,
    super.statuses,
    super.error,
    required this.id,
    required this.goToCart,
    required this.showDone,
  });

  factory DecreaseInitial.initial() {
    return const DecreaseInitial(
      result: false,
      id: 0,
      goToCart: false,
      showDone: false,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, showDone, goToCart];

  DecreaseInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    bool? goToCart,
    bool? showDone,
    int? id,
  }) {
    return DecreaseInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      goToCart: goToCart ?? this.goToCart,
      showDone: showDone ?? this.showDone,
    );
  }
}
