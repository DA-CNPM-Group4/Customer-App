// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealtimeLocation _$RealtimeLocationFromJson(Map<String, dynamic> json) =>
    RealtimeLocation(
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
      address: json['address'] as String,
    );

Map<String, dynamic> _$RealtimeLocationToJson(RealtimeLocation instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
      'address': instance.address,
    };
