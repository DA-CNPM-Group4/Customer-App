// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_trip_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateTripRequestBody _$RateTripRequestBodyFromJson(Map<String, dynamic> json) =>
    RateTripRequestBody(
      tripId: json['tripId'] as String,
      rate: (json['rate'] as num).toDouble(),
      description: json['description'] as String? ?? "",
    );

Map<String, dynamic> _$RateTripRequestBodyToJson(
        RateTripRequestBody instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'rate': instance.rate,
      'description': instance.description,
    };
