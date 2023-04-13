// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_trip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateTripResponse _$RateTripResponseFromJson(Map<String, dynamic> json) =>
    RateTripResponse(
      tripId: json['tripId'] as String,
      rate: (json['rate'] as num).toDouble(),
      note: json['note'] as String? ?? "",
    );

Map<String, dynamic> _$RateTripResponseToJson(RateTripResponse instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'rate': instance.rate,
      'note': instance.note,
    };
