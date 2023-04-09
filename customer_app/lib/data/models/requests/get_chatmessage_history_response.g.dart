// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_chatmessage_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageHistoryResponseBody _$ChatMessageHistoryResponseBodyFromJson(
        Map<String, dynamic> json) =>
    ChatMessageHistoryResponseBody(
      tripId: json['tripId'] as String?,
      driverId: json['driverId'] as String?,
      passengerId: json['passengerId'] as String?,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) =>
              ChatMessageResponseBody.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatMessageHistoryResponseBodyToJson(
        ChatMessageHistoryResponseBody instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'driverId': instance.driverId,
      'passengerId': instance.passengerId,
      'messages': instance.messages,
    };

ChatMessageResponseBody _$ChatMessageResponseBodyFromJson(
        Map<String, dynamic> json) =>
    ChatMessageResponseBody(
      tripId: json['tripId'] as String?,
      message: json['message'] as String,
      senderName: json['senderName'] as String?,
      sendTime: json['sendTime'] as String,
    );

Map<String, dynamic> _$ChatMessageResponseBodyToJson(
        ChatMessageResponseBody instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'message': instance.message,
      'senderName': instance.senderName,
      'sendTime': instance.sendTime,
    };
