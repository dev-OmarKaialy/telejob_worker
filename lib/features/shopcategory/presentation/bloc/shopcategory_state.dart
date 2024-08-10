part of 'shopcategory_bloc.dart';

class ShopcategoryState {
  final CubitStatus status;
  final List<ShopCategory> shopCategories;
  ShopcategoryState({
    this.status = CubitStatus.initial,
    this.shopCategories = const [],
  });

  ShopcategoryState copyWith({
    CubitStatus? status,
    List<ShopCategory>? shopCategories,
  }) {
    return ShopcategoryState(
      status: status ?? this.status,
      shopCategories: shopCategories ?? this.shopCategories,
    );
  }
}
