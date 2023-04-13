// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverEntity _$DriverEntityFromJson(Map<String, dynamic> json) => DriverEntity(
      accountId: json['accountId'] as String,
      identityNumber: json['identityNumber'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      gender: json['gender'] as bool,
      averageRate: (json['averageRate'] as num).toDouble(),
      numberOfRate: (json['numberOfRate'] as num).toDouble(),
      numberOfTrip: json['numberOfTrip'] as int,
    )..haveVehicleRegistered = json['haveVehicleRegistered'] as bool?;

Map<String, dynamic> _$DriverEntityToJson(DriverEntity instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'identityNumber': instance.identityNumber,
      'email': instance.email,
      'phone': instance.phone,
      'name': instance.name,
      'gender': instance.gender,
      'address': instance.address,
      'averageRate': instance.averageRate,
      'numberOfRate': instance.numberOfRate,
      'numberOfTrip': instance.numberOfTrip,
      'haveVehicleRegistered': instance.haveVehicleRegistered,
    };
