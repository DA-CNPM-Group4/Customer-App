// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_passenger_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePassengerRequestBody _$CreatePassengerRequestBodyFromJson(
        Map<String, dynamic> json) =>
    CreatePassengerRequestBody(
      Email: json['Email'] as String,
      Phone: json['Phone'] as String,
      Gender: json['Gender'] as bool,
      Name: json['Name'] as String,
      AccountId: json['AccountId'] as String?,
    );

Map<String, dynamic> _$CreatePassengerRequestBodyToJson(
        CreatePassengerRequestBody instance) =>
    <String, dynamic>{
      'Email': instance.Email,
      'Phone': instance.Phone,
      'Name': instance.Name,
      'AccountId': instance.AccountId,
      'Gender': instance.Gender,
    };
