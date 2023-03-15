// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealtimeTripRequest _$RealtimeTripRequestFromJson(Map<String, dynamic> json) =>
    RealtimeTripRequest(
      CreatedTime: json['CreatedTime'] as String,
      PassengerNote: json['PassengerNote'] as String,
      Distance: (json['Distance'] as num).toDouble(),
      Destination: json['Destination'] as String,
      LatDesAddr: (json['LatDesAddr'] as num).toDouble(),
      LongDesAddr: (json['LongDesAddr'] as num).toDouble(),
      StartAddress: json['StartAddress'] as String,
      LatStartAddr: (json['LatStartAddr'] as num).toDouble(),
      LongStartAddr: (json['LongStartAddr'] as num).toDouble(),
      PassengerPhone: json['PassengerPhone'] as String,
      Price: json['Price'] as int,
      VehicleType: json['VehicleType'] as String,
    )
      ..PassengerId = json['PassengerId'] as String?
      ..StaffId = json['StaffId'] as String
      ..RequestStatus = json['RequestStatus'] as String?;

Map<String, dynamic> _$RealtimeTripRequestToJson(
        RealtimeTripRequest instance) =>
    <String, dynamic>{
      'PassengerId': instance.PassengerId,
      'StaffId': instance.StaffId,
      'RequestStatus': instance.RequestStatus,
      'CreatedTime': instance.CreatedTime,
      'Destination': instance.Destination,
      'LatDesAddr': instance.LatDesAddr,
      'LongDesAddr': instance.LongDesAddr,
      'StartAddress': instance.StartAddress,
      'LatStartAddr': instance.LatStartAddr,
      'LongStartAddr': instance.LongStartAddr,
      'PassengerNote': instance.PassengerNote,
      'Distance': instance.Distance,
      'PassengerPhone': instance.PassengerPhone,
      'Price': instance.Price,
      'VehicleType': instance.VehicleType,
    };
