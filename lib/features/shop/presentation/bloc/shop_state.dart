part of 'shop_bloc.dart';

class ShopState {
  final CubitStatus status;
  final CubitStatus productsStatus;
  final List<Shop> shops;
  final List<ProductModel> products;
  ShopState({
    this.status = CubitStatus.initial,
    this.productsStatus = CubitStatus.initial,
    this.shops = const [],
    this.products = const [],
  });

  ShopState copyWith({
    CubitStatus? status,
    CubitStatus? productsStatus,
    List<Shop>? shops,
    List<ProductModel>? products,
  }) {
    return ShopState(
      status: status ?? this.status,
      productsStatus: productsStatus ?? this.productsStatus,
      shops: shops ?? this.shops,
      products: products ?? this.products,
    );
  }
}
