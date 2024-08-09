import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'joprequest_event.dart';
part 'joprequest_state.dart';

class JoprequestBloc extends Bloc<JoprequestEvent, JoprequestState> {
  JoprequestBloc() : super(JoprequestInitial()) {
    on<JoprequestEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
