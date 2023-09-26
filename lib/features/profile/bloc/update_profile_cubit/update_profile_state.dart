part of 'update_profile_cubit.dart';

class UpdateProfileInitial {
  final CubitStatuses statuses;
  final bool result;
  final String error;
  final String image;

  const UpdateProfileInitial({
    required this.statuses,
    required this.result,
    required this.image,
    required this.error,
  });

  factory UpdateProfileInitial.initial() {
    return const UpdateProfileInitial(
      result: false,
      error: '',
      image: 'AppSharedPreference.getUserModel().photo.url',
      statuses: CubitStatuses.init,
    );
  }


  UpdateProfileInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? image,
    String? error,
  }) {
    return UpdateProfileInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      image: image ?? this.image,
      error: error ?? this.error,
    );
  }
}
