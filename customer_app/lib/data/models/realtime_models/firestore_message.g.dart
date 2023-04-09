// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreMessageModel _$FirestoreMessageModelFromJson(
        Map<String, dynamic> json) =>
    FirestoreMessageModel(
      date: json['date'] as String?,
      message: json['message'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
    );

Map<String, dynamic> _$FirestoreMessageModelToJson(
        FirestoreMessageModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'message': instance.message,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
    };
