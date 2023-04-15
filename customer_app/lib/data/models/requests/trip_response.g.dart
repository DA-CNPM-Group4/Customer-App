// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripResponse _$TripResponseFromJson(Map<String, dynamic> json) => TripResponse(
      tripId: json['tripId'] as String,
      requestId: json['requestId'] as String,
      driverId: json['driverId'] as String,
      passengerId: json['passengerId'] as String,
      staffId: json['staffId'] as String,
      vehicleId: json['vehicleId'] as String,
      completeTime: json['completeTime'] == null
          ? null
          : DateTime.parse(json['completeTime'] as String),
      createdTime: DateTime.parse(json['createdTime'] as String),
      destination: json['destination'] as String,
      latDesAddr: (json['latDesAddr'] as num).toDouble(),
      longStartAddr: (json['longStartAddr'] as num).toDouble(),
      startAddress: json['startAddress'] as String,
      latStartAddr: (json['latStartAddr'] as num).toDouble(),
      longDesAddr: (json['longDesAddr'] as num).toDouble(),
      tripStatus: json['tripStatus'] as String,
      distance: (json['distance'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      vehicleType: json['vehicleType'] as String,
      timeSecond: (json['timeSecond'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TripResponseToJson(TripResponse instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'requestId': instance.requestId,
      'driverId': instance.driverId,
      'passengerId': instance.passengerId,
      'staffId': instance.staffId,
      'vehicleId': instance.vehicleId,
      'completeTime': instance.completeTime?.toIso8601String(),
      'createdTime': instance.createdTime.toIso8601String(),
      'destination': instance.destination,
      'latDesAddr': instance.latDesAddr,
      'longDesAddr': instance.longDesAddr,
      'startAddress': instance.startAddress,
      'latStartAddr': instance.latStartAddr,
      'longStartAddr': instance.longStartAddr,
      'tripStatus': instance.tripStatus,
      'distance': instance.distance,
      'price': instance.price,
      'vehicleType': instance.vehicleType,
      'timeSecond': instance.timeSecond,
    };
