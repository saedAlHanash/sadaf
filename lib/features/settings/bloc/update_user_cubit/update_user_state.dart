// part of 'update_user_cubit.dart';
//
// class UpdateUserInitial extends Equatable {
//   final CubitStatuses statuses;
//   final String result;
//   final String error;
//
//   const UpdateUserInitial({
//     required this.statuses,
//     required this.result,
//     required this.error,
//   });
//
//   factory UpdateUserInitial.initial() {
//     return const UpdateUserInitial(
//       result: '',
//       error: '',
//       statuses: CubitStatuses.init,
//     );
//   }
//
//   @override
//   List<Object> get props => [statuses, result, error];
//
//   UpdateUserInitial copyWith({
//     CubitStatuses? statuses,
//     String? result,
//     String? error,
//   }) {
//     return UpdateUserInitial(
//       statuses: statuses ?? this.statuses,
//       result: result ?? this.result,
//       error: error ?? this.error,
//     );
//   }
// }
