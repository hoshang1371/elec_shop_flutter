// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['email'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };