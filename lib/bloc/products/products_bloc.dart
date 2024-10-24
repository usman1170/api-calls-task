import 'package:api_calls/models/products_model.dart';
import 'package:api_calls/repository/product_repository.dart';
import 'package:api_calls/utils/emuns.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final _productRepository = ProductRepository();
  ProductsBloc() : super(const ProductsState()) {
    on<ProductsFetchedEvent>(_getProducts);
  }
  void _getProducts(ProductsFetchedEvent event, emit) async {
    try {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
      final result = await _productRepository.getProducts();

      emit(state.copyWith(products: result));
      emit(state.copyWith(apiCallStatus: ApiCallStatus.success));
    } catch (e) {
      emit(state.copyWith(msg: e.toString()));
      emit(state.copyWith(apiCallStatus: ApiCallStatus.failed));
    }
  }
}
