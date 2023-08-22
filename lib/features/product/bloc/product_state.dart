// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

enum ProductStatus { initial, loading, loaded, error }

enum PaymentStatus { initial, loading, loaded, success, error }

class ProductState extends Equatable {
  final ProductStatus status;
  final PaymentStatus paymentStatus;
  final String errorMessage;
  final List<Product> products;
  final String paymentUrl;

  const ProductState({
    required this.status,
    required this.paymentStatus,
    required this.errorMessage,
    required this.products,
    required this.paymentUrl,
  });

  factory ProductState.initial() {
    return const ProductState(
      status: ProductStatus.initial,
      paymentStatus: PaymentStatus.initial,
      errorMessage: '',
      products: [],
      paymentUrl: '',
    );
  }

  @override
  List<Object> get props =>
      [status, paymentStatus, errorMessage, products, paymentUrl];

  ProductState copyWith({
    ProductStatus? status,
    PaymentStatus? paymentStatus,
    String? errorMessage,
    List<Product>? products,
    String? paymentUrl,
  }) {
    return ProductState(
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      products: products ?? this.products,
      paymentUrl: paymentUrl ?? this.paymentUrl,
    );
  }
}
