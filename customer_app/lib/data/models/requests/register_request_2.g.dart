// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestBodyV2 _$RegisterRequestBodyV2FromJson(
        Map<String, dynamic> json) =>
    RegisterRequestBodyV2(
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      name: json['name'] as String,
      gender: json['gender'] as bool,
      mode: json['mode'] as String? ?? "2",
    );

Map<String, dynamic> _$RegisterRequestBodyV2ToJson(
        RegisterRequestBodyV2 instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'role': instance.role,
      'gender': instance.gender,
      'name': instance.name,
      'mode': instance.mode,
    };
