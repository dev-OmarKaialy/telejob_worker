import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:worker/features/categories/presentation/bloc/categories_bloc.dart';

import '../../data/models/requestsmodel.dart';
import '../../data/repositories/requestsrepo.dart';

part 'joprequest_event.dart';
part 'joprequest_state.dart';

class JoprequestBloc extends Bloc<JoprequestEvent, JoprequestState> {
  JoprequestBloc() : super(JoprequestState()) {
    on<GetJobRequestsEvent>((event, emit) async {
      emit(state.copyWith(status: CubitStatus.loading));
      final result = await Requestsrepo().getrequests();
      result.fold((left) {
        emit(state.copyWith(status: CubitStatus.failed));
      }, (right) {
        emit(
          state.copyWith(status: CubitStatus.success, requests: right.requests),
        );
      });
    });
  }
}
