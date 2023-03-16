// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealtimeTripRequest _$RealtimeTripRequestFromJson(Map<String, dynamic> json) =>
    RealtimeTripRequest(
      CreatedTime: json['CreatedTime'] as String,
      DriverId: json['DriverId'] as String?,
      Distance: (json['Distance'] as num).toDouble(),
      Destination: json['Destination'] as String,
      LatDesAddr: (json['LatDesAddr'] as num).toDouble(),
      LongDesAddr: (json['LongDesAddr'] as num).toDouble(),
      StartAddress: json['StartAddress'] as String,
      LatStartAddr: (json['LatStartAddr'] as num).toDouble(),
      LongStartAddr: (json['LongStartAddr'] as num).toDouble(),
      VehicleType: json['VehicleType'] as String?,
      VehicleId: json['VehicleId'] as String?,
      PassengerId: json['PassengerId'] as String?,
      StaffId: json['StaffId'] as String,
      TripId: json['TripId'] as String?,
      TripStatus: json['TripStatus'] as String?,
    );

Map<String, dynamic> _$RealtimeTripRequestToJson(
        RealtimeTripRequest instance) =>
    <String, dynamic>{
      'CreatedTime': instance.CreatedTime,
      'Destination': instance.Destination,
      'Distance': instance.Distance,
      'DriverId': instance.DriverId,
      'PassengerId': instance.PassengerId,
      'StaffId': instance.StaffId,
      'LatDesAddr': instance.LatDesAddr,
      'LongDesAddr': instance.LongDesAddr,
      'StartAddress': instance.StartAddress,
      'LatStartAddr': instance.LatStartAddr,
      'LongStartAddr': instance.LongStartAddr,
      'TripId': instance.TripId,
      'TripStatus': instance.TripStatus,
      'VehicleId': instance.VehicleId,
      'VehicleType': instance.VehicleType,
    };
