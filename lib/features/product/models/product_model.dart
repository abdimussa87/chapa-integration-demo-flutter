// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  const Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.id,
  });

  // this function is a factory constructor for creating a Product object from a JSON map.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  @override
  List<Object> get props => [id, name, imageUrl, price];
}
