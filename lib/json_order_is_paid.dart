import 'package:json_annotation/json_annotation.dart';

part 'json_order_is_paid.g.dart';

@JsonSerializable()
class OrderIsPaid {
  // ignore: non_constant_identifier_names
  final String? is_paid;
  final String? owner;

  // ignore: non_constant_identifier_names
  OrderIsPaid({this.is_paid, this.owner});

  factory OrderIsPaid.fromJson(Map<String, dynamic> json) => _$OrderIsPaidFromJson(json);

  Map<String, dynamic> toJson() => _$OrderIsPaidToJson(this);

  @override
  String toString() => 'OrderIsPaid{is_paid: $is_paid, owner: $owner}';

}
