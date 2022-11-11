import 'package:json_annotation/json_annotation.dart';

part 'json_product.g.dart';

@JsonSerializable()
class Product {
  final String? count;
  final String? product;

  Product({this.count, this.product});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  String toString() => 'Product{email: $count, password: $product}';
  // User.fromJson(Map<String, dynamic> json)
  //     :  email = json['email'],
  //      password = json['password'];

  // Map<String, dynamic> toJson() => {
  //       'email': email,
  //       'password': password,
  //     };
}
