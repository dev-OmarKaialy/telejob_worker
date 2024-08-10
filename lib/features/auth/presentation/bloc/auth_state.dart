part of 'auth_bloc.dart';

class AuthState {
  final CubitStatus status;
  AuthState({
    this.status = CubitStatus.initial,
  });

  AuthState copyWith({
    CubitStatus? status,
  }) {
    return AuthState(
      status: status ?? this.status,
    );
  }
}
