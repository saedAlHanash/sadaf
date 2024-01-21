part of 'driver_location_cubit.dart';

class DriverLocationInitial extends AbstractCubit<Coordinate> {
  final int orderId;

  const DriverLocationInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.orderId,
  });

  factory DriverLocationInitial.initial() {
    return DriverLocationInitial(
      result: Coordinate.fromJson({}),
      orderId: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DriverLocationInitial copyWith({
    CubitStatuses? statuses,
    Coordinate? result,
    String? error,
    int? orderId,
  }) {
    return DriverLocationInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      orderId: orderId ?? this.orderId,
    );
  }
}
