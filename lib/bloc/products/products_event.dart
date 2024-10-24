part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductsFetchedEvent extends ProductsEvent {
  @override
  List<Object> get props => [];
}
