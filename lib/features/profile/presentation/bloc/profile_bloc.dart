import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:worker/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:worker/features/profile/data/models/profilemodel.dart';
import 'package:worker/features/profile/data/repositories/profilerepo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<GetProfile>((event, emit) async {
      emit(state.copyWith(status: CubitStatus.loading));

      final result = await Profilerepo().getprofile();
      result.fold((left) {
        emit(state.copyWith(status: CubitStatus.failed));
      }, (right) {
        emit(state.copyWith(status: CubitStatus.success, profile: right));
      });
    });
    on<UpdateProfile>((event, emit) async {
      emit(state.copyWith(status: CubitStatus.loading));

      final result = await Profilerepo().putprofile();
      result.fold((left) {
        emit(state.copyWith(status: CubitStatus.failed));
      }, (right) {
        emit(state.copyWith(status: CubitStatus.success, profile: right));
      });
    });
  }
}
