part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class GetShopsEvent extends ShopEvent {}

class GetShopProductssEvent extends ShopEvent {
  final String id;

  const GetShopProductssEvent({required this.id});
}
