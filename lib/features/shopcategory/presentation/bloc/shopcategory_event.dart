part of 'shopcategory_bloc.dart';

abstract class ShopcategoryEvent extends Equatable {
  const ShopcategoryEvent();

  @override
  List<Object> get props => [];
}

class GetShopCategoryEvent extends ShopcategoryEvent {}
