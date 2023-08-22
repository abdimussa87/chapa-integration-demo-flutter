part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProducts extends ProductEvent {}

class BuyProduct extends ProductEvent {
  final String productId;
  const BuyProduct({
    required this.productId,
  });
}

class PaymentSuccessful extends ProductEvent {}
