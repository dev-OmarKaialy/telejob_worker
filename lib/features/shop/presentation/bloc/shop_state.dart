part of 'shop_bloc.dart';

class ShopState {
  final CubitStatus status;
  final List<Shop> shops;
  ShopState({
    this.status = CubitStatus.initial,
    this.shops = const [],
  });

  ShopState copyWith({
    CubitStatus? status,
    List<Shop>? shops,
  }) {
    return ShopState(
      status: status ?? this.status,
      shops: shops ?? this.shops,
    );
  }
}
