// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_passenger_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePassengerRequestBody _$UpdatePassengerRequestBodyFromJson(
        Map<String, dynamic> json) =>
    UpdatePassengerRequestBody(
      Email: json['Email'] as String,
      Phone: json['Phone'] as String,
      Gender: json['Gender'] as bool,
      Name: json['Name'] as String,
      AccountId: json['AccountId'] as String?,
    );

Map<String, dynamic> _$UpdatePassengerRequestBodyToJson(
        UpdatePassengerRequestBody instance) =>
    <String, dynamic>{
      'Email': instance.Email,
      'Phone': instance.Phone,
      'Name': instance.Name,
      'AccountId': instance.AccountId,
      'Gender': instance.Gender,
    };
