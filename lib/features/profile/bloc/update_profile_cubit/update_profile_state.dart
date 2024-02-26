part of 'update_profile_cubit.dart';

class UpdateProfileInitial extends AbstractCubit<Profile> {
  final UpdateProfileRequest request;
  final UpdateProfileType type;

  const UpdateProfileInitial({
    required super.result,
    required this.request,
    required this.type,
    super.error,
    super.statuses,
  });

  @override
  List<Object> get props => [statuses, result, error];

  factory UpdateProfileInitial.initial() {
    return UpdateProfileInitial(
      request: UpdateProfileRequest.initial(),
      type: UpdateProfileType.normal,
      result: AppProvider.profile,
    );
  }

  UpdateProfileInitial copyWith({
    CubitStatuses? statuses,
    Profile? result,
    String? image,
    String? error,
    UpdateProfileRequest? request,
    UpdateProfileType? type,
  }) {
    return UpdateProfileInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      type: type ?? this.type,
    );
  }
}
