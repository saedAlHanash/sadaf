part of 'notification_count_cubit.dart';

class NotificationCountInitial extends Equatable {
  final int result;

  const NotificationCountInitial({required this.result});

  factory NotificationCountInitial.initial() {
    return NotificationCountInitial(result: AppSharedPreference.getNotificationCount());
  }

  NotificationCountInitial copyWith({
    int? result,
  }) {
    return NotificationCountInitial(
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [result];
}
