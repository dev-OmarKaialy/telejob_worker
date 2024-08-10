part of 'profile_bloc.dart';

class ProfileState {
  final CubitStatus status;
  final ProfileModel? profile;
  ProfileState({
    this.status = CubitStatus.initial,
    this.profile,
  });

  ProfileState copyWith({
    CubitStatus? status,
    ProfileModel? profile,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
    );
  }
}
