import 'package:json_annotation/json_annotation.dart';

part 'driver_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class DriverEntity {
  String accountId;

  String identityNumber;

  String email;

  String phone;

  String name;

  bool gender;

  String address;

  double averageRate;

  double numberOfRate;

  int numberOfTrip;

  bool? haveVehicleRegistered;

  DriverEntity({
    required this.accountId,
    required this.identityNumber,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.gender,
    required this.averageRate,
    required this.numberOfRate,
    required this.numberOfTrip,
  });

  factory DriverEntity.fromJson(Map<String, dynamic> json) =>
      _$DriverEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DriverEntityToJson(this);
}
