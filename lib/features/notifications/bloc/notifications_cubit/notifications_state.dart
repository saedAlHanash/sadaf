part of 'notifications_cubit.dart';

class NotificationsInitial extends AbstractCubit<List<NotificationModel>> {
  final int mId;

  const NotificationsInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.mId,
  });

  factory NotificationsInitial.initial() {
    return const NotificationsInitial(
      result: [],
      mId: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  NotificationsInitial copyWith({
    CubitStatuses? statuses,
    List<NotificationModel>? result,
    String? error,
    int? mId,
  }) {
    return NotificationsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      mId: mId ?? this.mId,
    );
  }
}
