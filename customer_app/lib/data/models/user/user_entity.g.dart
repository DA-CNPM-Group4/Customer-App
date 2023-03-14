// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      id: json['id'] as int?,
      homeAddress: json['homeAddress'] as String?,
      gender: json['gender'],
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'homeAddress': instance.homeAddress,
      'gender': instance.gender,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'fullName': instance.fullName,
    };
