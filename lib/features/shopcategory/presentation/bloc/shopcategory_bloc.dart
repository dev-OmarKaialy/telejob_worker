import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:worker/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:worker/features/shopcategory/data/models/shopcategorymodel.dart';
import 'package:worker/features/shopcategory/data/repositories/shopcategories.dart';

part 'shopcategory_event.dart';
part 'shopcategory_state.dart';

class ShopcategoryBloc extends Bloc<ShopcategoryEvent, ShopcategoryState> {
  ShopcategoryBloc() : super(ShopcategoryState()) {
    on<GetShopCategoryEvent>((event, emit) async {
      emit(state.copyWith(status: CubitStatus.loading));
      final result = await Shopcategoriesrepo().getshopCategories();

      result.fold((left) {
        emit(state.copyWith(status: CubitStatus.failed));
      }, (right) {
        emit(state.copyWith(
            status: CubitStatus.success, shopCategories: right.shopCategories));
      });
    });
  }
}
