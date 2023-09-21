part of 'notifications_cubit.dart';

class NotificationsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<NotificationModel> result;
  final String error;

  const NotificationsInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory NotificationsInitial.initial() {
    return const NotificationsInitial(
      result: <NotificationModel>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  NotificationsInitial copyWith({
    CubitStatuses? statuses,
    List<NotificationModel>? result,
    String? error,
  }) {
    return NotificationsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}