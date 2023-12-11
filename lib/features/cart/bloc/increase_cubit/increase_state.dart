part of 'increase_cubit.dart';

class IncreaseInitial extends AbstractCubit<bool> {
  final int id;
  final bool goToCart;
  final bool showDone;

  const IncreaseInitial({
    required super.result,
    super.statuses,
    super.error,
    required this.id,
    required this.goToCart,
    required this.showDone,
  });

  factory IncreaseInitial.initial() {
    return const IncreaseInitial(
      result: false,
      id: 0,
      goToCart: false,
      showDone: false,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, showDone, goToCart];

  IncreaseInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    bool? goToCart,
    bool? showDone,
    int? id,
  }) {
    return IncreaseInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      goToCart: goToCart ?? this.goToCart,
      showDone: showDone ?? this.showDone,
    );
  }
}
