import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';
@HiveType(typeId: 0)
@JsonSerializable()
class UserEntity extends HiveObject{
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? homeAddress;
  @HiveField(2)
  dynamic gender;
  @HiveField(3)
  String? phoneNumber;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? fullName;

  UserEntity(
      {required this.id,
        required this.homeAddress,
        required this.gender,
        required this.phoneNumber,
        required this.email,
        required this.fullName});

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);


}