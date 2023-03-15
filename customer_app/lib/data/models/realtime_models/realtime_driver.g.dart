// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealtimeDriver _$RealtimeDriverFromJson(Map<String, dynamic> json) =>
    RealtimeDriver(
      info: RealtimeDriverInfo.fromJson(json['info'] as Map<String, dynamic>),
      vehicle: RealtimeDriverVehicle.fromJson(
          json['vehicle'] as Map<String, dynamic>),
      location:
          RealtimeLocation.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RealtimeDriverToJson(RealtimeDriver instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'vehicle': instance.vehicle.toJson(),
      'location': instance.location.toJson(),
    };

RealtimeDriverInfo _$RealtimeDriverInfoFromJson(Map<String, dynamic> json) =>
    RealtimeDriverInfo(
      phone: json['phone'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$RealtimeDriverInfoToJson(RealtimeDriverInfo instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'name': instance.name,
    };

RealtimeDriverVehicle _$RealtimeDriverVehicleFromJson(
        Map<String, dynamic> json) =>
    RealtimeDriverVehicle(
      brand: json['brand'] as String,
      name: json['name'] as String,
      vehicleId: json['vehicleId'] as String,
    );

Map<String, dynamic> _$RealtimeDriverVehicleToJson(
        RealtimeDriverVehicle instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'name': instance.name,
      'vehicleId': instance.vehicleId,
    };
