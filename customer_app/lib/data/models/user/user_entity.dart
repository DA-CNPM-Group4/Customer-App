import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class UserEntity extends HiveObject {
  @HiveField(0)
  String? accountId;
  @HiveField(1)
  String? name;
  @HiveField(2)
  dynamic gender;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  String? email;

  UserEntity({
    required this.accountId,
    required this.name,
    required this.gender,
    required this.phone,
    required this.email,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
