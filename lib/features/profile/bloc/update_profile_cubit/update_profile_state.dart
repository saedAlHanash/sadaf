part of 'update_profile_cubit.dart';

class UpdateProfileInitial extends AbstractCubit<Profile> {
  final UpdateProfileRequest request;

  const UpdateProfileInitial({
    required super.result,
    required this.request,
    super.error,
    super.statuses,
  });

  @override
  List<Object> get props => [statuses, result, error];

  factory UpdateProfileInitial.initial() {
    return UpdateProfileInitial(
      request: UpdateProfileRequest.initial(),
      result: AppSharedPreference.getProfile,
    );
  }

  UpdateProfileInitial copyWith({
    CubitStatuses? statuses,
    Profile? result,
    String? image,
    String? error,
    UpdateProfileRequest? request,
  }) {
    return UpdateProfileInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
