part of 'joprequest_bloc.dart';

abstract class JoprequestEvent extends Equatable {
  const JoprequestEvent();

  @override
  List<Object> get props => [];
}

class GetJobRequestsEvent extends JoprequestEvent {}
