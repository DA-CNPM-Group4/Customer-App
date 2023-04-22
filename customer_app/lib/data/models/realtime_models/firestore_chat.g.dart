// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreChatModel _$FirestoreChatModelFromJson(Map<String, dynamic> json) =>
    FirestoreChatModel(
      createTime: json['createTime'] as String,
      driverId: json['driverId'] as String,
      passengerId: json['passengerId'] as String,
    );

Map<String, dynamic> _$FirestoreChatModelToJson(FirestoreChatModel instance) =>
    <String, dynamic>{
      'createTime': instance.createTime,
      'driverId': instance.driverId,
      'passengerId': instance.passengerId,
    };
