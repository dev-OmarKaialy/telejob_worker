import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:worker/core/services/shared_preferences_service.dart';
import 'package:worker/features/auth/data/repositories/auth_repo.dart';
import 'package:worker/features/categories/presentation/bloc/categories_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<LoginEvent>((event, emit) async {
      emit(state.copyWith(status: CubitStatus.loading));
      final result = await AuthRepo()
          .login({'email': event.email, 'password': event.password});
      result.fold((left) {
        emit(state.copyWith(status: CubitStatus.failed));
      }, (right) async {
        emit(state.copyWith(status: CubitStatus.success));
        await SharedPreferencesService.setToken(right.jwt!);
      });
    });
    on<RegisterEvent>((event, emit) async {
      emit(state.copyWith(status: CubitStatus.loading));
      final result = await AuthRepo().login(event.toMap());
      result.fold((left) {
        emit(state.copyWith(status: CubitStatus.failed));
      }, (right) async {
        emit(state.copyWith(status: CubitStatus.success));
        await SharedPreferencesService.setToken(right.jwt!);
      });
    });
  }
}
