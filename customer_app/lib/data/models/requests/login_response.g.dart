// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseBody _$LoginResponseBodyFromJson(Map<String, dynamic> json) =>
    LoginResponseBody(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      accountId: json['accountId'] as String,
      isEmailValidated: json['isEmailValidated'] as bool?,
    );

Map<String, dynamic> _$LoginResponseBodyToJson(LoginResponseBody instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'accountId': instance.accountId,
      'isEmailValidated': instance.isEmailValidated,
    };
