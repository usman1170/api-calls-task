part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final List<ProductModel> products;
  final String msg;
  final ApiCallStatus apiCallStatus;

  const ProductsState({
    this.products = const [],
    this.msg = "",
    this.apiCallStatus = ApiCallStatus.initial,
  });

  ProductsState copyWith({
    List<ProductModel>? products,
    String? msg,
    ApiCallStatus? apiCallStatus,
  }) {
    return ProductsState(
      products: products ?? this.products,
      msg: msg ?? this.msg,
      apiCallStatus: apiCallStatus ?? this.apiCallStatus,
    );
  }

  @override
  List<Object?> get props => [msg, apiCallStatus, products];
}
