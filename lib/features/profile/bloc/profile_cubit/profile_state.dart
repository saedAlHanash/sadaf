part of 'profile_cubit.dart';

class ProfileInitial extends AbstractCubit<Profile> {
  final int id;

  const ProfileInitial({
    required super.result,
    required this.id,
    super.error,
    super.statuses,
  });

  factory ProfileInitial.initial() {
    return ProfileInitial(
      result: AppSharedPreference.getProfile,
      id: 0,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ProfileInitial copyWith({
    CubitStatuses? statuses,
    Profile? result,
    String? error,
    int? id,
  }) {
    return ProfileInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }
}
