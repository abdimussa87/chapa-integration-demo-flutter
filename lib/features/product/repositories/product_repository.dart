import 'package:chapa_integration/constants.dart';
import 'package:chapa_integration/features/product/models/product_model.dart';
import 'package:dio/dio.dart';

class ProductRepository {
  final Dio _dio;

  ProductRepository({Dio? dio}) : _dio = dio ?? Dio();

  // fetch products
  Future<List<Product>> getProducts() async {
    List<Product> products = [];
    var response = await _dio.get(
      '$baseUrl/api/products',
    );
    response.data['products'].forEach((json) {
      products.add(Product.fromJson(json));
    });
    return products;
  }

  Future<String> buy({
    required String productId,
  }) async {
    final response = await _dio.post(
      '$baseUrl/api/orders',
      data: {'productId': productId},
    );
    return response.data['paymentUrl'];
  }
}
