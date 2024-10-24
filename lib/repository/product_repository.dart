import 'dart:developer';
import 'package:api_calls/data/network_api_service.dart';
import 'package:api_calls/models/products_model.dart';
import 'package:api_calls/utils/helper.dart';

class ProductRepository {
  final _api = NetworkApiService();
  // final _hiveService = HiveService();

  Future<List<ProductModel>> getProducts() async {
    try {
      final res = await _api.getApi(productsUrl);

      log('Raw response: $res');

      if (res is Map<String, dynamic>) {
        List<ProductModel> products = List<ProductModel>.from(
          res['products'].map((product) => ProductModel.fromMap(product)),
        );
        return products;
      } else {
        log('Error: $res');
        throw Exception('Failed to fetch products, unexpected response format');
      }
    } catch (error) {
      log('Error getting products: $error');
      throw Exception('Error getting products: $error');
    }
  }
}
