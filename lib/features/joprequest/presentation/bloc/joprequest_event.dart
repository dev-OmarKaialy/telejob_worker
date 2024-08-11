part of 'joprequest_bloc.dart';

abstract class JoprequestEvent extends Equatable {
  const JoprequestEvent();

  @override
  List<Object> get props => [];
}

class GetJobRequestsEvent extends JoprequestEvent {}

class UpdateJobRequestsEvent extends JoprequestEvent {
  final String id;
  final bool status;

  const UpdateJobRequestsEvent({required this.id, required this.status});
}
