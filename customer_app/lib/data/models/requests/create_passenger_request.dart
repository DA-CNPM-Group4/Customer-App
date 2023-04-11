// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'create_passenger_request.g.dart';

@JsonSerializable()
class CreatePassengerRequestBody {
  String Email;
  String Phone;
  String Name;
  String? AccountId;
  bool Gender;

  CreatePassengerRequestBody(
      {required this.Email,
      required this.Phone,
      required this.Gender,
      required this.Name,
      this.AccountId});

  factory CreatePassengerRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreatePassengerRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePassengerRequestBodyToJson(this);
}
