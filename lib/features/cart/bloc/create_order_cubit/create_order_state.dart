part of 'create_order_cubit.dart';

class CreateOrderInitial extends AbstractCubit<bool> {
  final String paymentUrl;
  final PaymentMethod paymentMethod;

  const CreateOrderInitial({
    required super.result,
    super.statuses,
    super.error,
    required this.paymentUrl,
    required this.paymentMethod,
  });

  factory CreateOrderInitial.initial() {
    return const CreateOrderInitial(
      result: false,
      paymentUrl: '',
      paymentMethod: PaymentMethod.cash,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateOrderInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    String? paymentUrl,
    PaymentMethod? paymentMethod,
  }) {
    return CreateOrderInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
