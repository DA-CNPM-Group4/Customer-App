// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_passenger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealtimePassenger _$RealtimePassengerFromJson(Map<String, dynamic> json) =>
    RealtimePassenger(
      info:
          RealtimePassengerInfo.fromJson(json['info'] as Map<String, dynamic>),
      location:
          RealtimeLocation.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RealtimePassengerToJson(RealtimePassenger instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'location': instance.location.toJson(),
    };

RealtimePassengerInfo _$RealtimePassengerInfoFromJson(
        Map<String, dynamic> json) =>
    RealtimePassengerInfo(
      phone: json['phone'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$RealtimePassengerInfoToJson(
        RealtimePassengerInfo instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'name': instance.name,
    };
