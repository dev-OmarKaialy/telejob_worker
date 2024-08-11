import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:worker/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:worker/features/shop/data/models/shop_products.dart';

import '../../data/models/shopmodel.dart';
import '../../data/repositories/shoprepo.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopState()) {
    on<GetShopsEvent>((event, emit) async {
      emit(state.copyWith(status: CubitStatus.loading));
      final result = await ShopRepo().getshop();
      result.fold((left) {
        emit(state.copyWith(status: CubitStatus.failed));
      }, (right) {
        emit(
          state.copyWith(status: CubitStatus.success, shops: right.shops),
        );
      });
    });
    on<GetShopProductssEvent>((event, emit) async {
      emit(state.copyWith(productsStatus: CubitStatus.loading));
      final result = await ShopRepo().getShopProducts(event.id);
      result.fold((left) {
        emit(state.copyWith(productsStatus: CubitStatus.failed));
      }, (right) {
        emit(
          state.copyWith(
              productsStatus: CubitStatus.success, products: right.products),
        );
      });
    });
  }
}
