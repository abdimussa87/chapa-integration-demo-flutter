import 'dart:io';

import 'package:chapa_integration/features/product/models/product_model.dart';
import 'package:chapa_integration/features/product/repositories/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  ProductBloc({
    ProductRepository? productRepository,
    Dio? dio,
  })  : _productRepository = productRepository ?? ProductRepository(dio: Dio()),
        super(ProductState.initial()) {
    on<GetProducts>(_onGetProducts);
    on<BuyProduct>(_onBuyProduct);
    on<PaymentSuccessful>(_onPaymentSuccessful);
  }

  Future<void> _onGetProducts(
    GetProducts event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ProductStatus.loading));
      final products = await _productRepository.getProducts();
      emit(state.copyWith(
        status: ProductStatus.loaded,
        products: products,
      ));
    } catch (e) {
      var errorMessage = getError(e);
      emit(state.copyWith(
          status: ProductStatus.error, errorMessage: errorMessage));
    }
  }

  Future<void> _onBuyProduct(
    BuyProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(state.copyWith(paymentStatus: PaymentStatus.loading));
      final paymentUrl =
          await _productRepository.buy(productId: event.productId);
      emit(state.copyWith(
        paymentStatus: PaymentStatus.loaded,
        paymentUrl: paymentUrl,
      ));
    } catch (e) {
      var errorMessage = getError(e);
      emit(state.copyWith(
          status: ProductStatus.error, errorMessage: errorMessage));
    }
  }

  void _onPaymentSuccessful(
    PaymentSuccessful event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(paymentStatus: PaymentStatus.success));
  }
}

String getError(e) {
  String errorMessage = 'Something went wrong';
  if (e is DioException) {
    if (e.error is SocketException) {
      errorMessage = "No Internet Connection!";
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      errorMessage = "Request timeout";
    } else if (e.type == DioExceptionType.badResponse) {
      final response = e.response;

      if (response != null && response.data != null) {
        try {
          final Map responseData = response.data as Map;
          errorMessage = responseData['msg'] ?? '';
        } catch (e) {
          errorMessage = 'Something went wrong';
        }
      }
    }
  }
  return errorMessage;
}
