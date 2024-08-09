import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shopcategory_event.dart';
part 'shopcategory_state.dart';

class ShopcategoryBloc extends Bloc<ShopcategoryEvent, ShopcategoryState> {
  ShopcategoryBloc() : super(ShopcategoryInitial()) {
    on<ShopcategoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
