// part of 'create_order_cubit.dart';
//
// class CreateOrderInitial extends Equatable {
//   final CubitStatuses statuses;
//   final bool result;
//   final String error;
//
//   const CreateOrderInitial({
//     required this.statuses,
//     required this.result,
//     required this.error,
//   });
//
//   factory CreateOrderInitial.initial() {
//     return const CreateOrderInitial(
//       result: false,
//       error: '',
//       statuses: CubitStatuses.init,
//     );
//   }
//
//   @override
//   List<Object> get props => [statuses, result, error];
//
//   CreateOrderInitial copyWith({
//     CubitStatuses? statuses,
//     bool? result,
//     String? error,
//   }) {
//     return CreateOrderInitial(
//       statuses: statuses ?? this.statuses,
//       result: result ?? this.result,
//       error: error ?? this.error,
//     );
//   }
//
// }