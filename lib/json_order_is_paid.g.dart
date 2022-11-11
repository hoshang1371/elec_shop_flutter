// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_order_is_paid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderIsPaid _$OrderIsPaidFromJson(Map<String, dynamic> json) => OrderIsPaid(
      is_paid: json['is_paid'] as String?,
      owner: json['owner'] as String?,
    );

Map<String, dynamic> _$OrderIsPaidToJson(OrderIsPaid instance) =>
    <String, dynamic>{
      'is_paid': instance.is_paid,
      'owner': instance.owner,
    };
