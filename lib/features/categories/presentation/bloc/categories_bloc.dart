import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:worker/features/categories/data/models/categoriesmodel.dart';
import 'package:worker/features/categories/data/repositories/categoriesrepo.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesState()) {
    on<IndexCategories>((event, emit) async {
      emit(state.copyWith(status: CubitStatus.loading));
      final result = await Categoriesrepo().getCategories();
      result.fold((left) {
        emit(state.copyWith(status: CubitStatus.failed));
      }, (right) {
        emit(
          state.copyWith(
            status: CubitStatus.success,
            model: right.jobCategories,
          ),
        );
      });
    });
  }
}
