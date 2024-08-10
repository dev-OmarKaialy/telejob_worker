part of 'joprequest_bloc.dart';

class JoprequestState {
  final CubitStatus status;
  final List<Request> requests;
  JoprequestState({
    this.status = CubitStatus.initial,
    this.requests = const [],
  });

  JoprequestState copyWith({
    CubitStatus? status,
    List<Request>? requests,
  }) {
    return JoprequestState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
    );
  }
}
