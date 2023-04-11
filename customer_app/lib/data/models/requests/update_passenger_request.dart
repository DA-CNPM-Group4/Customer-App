// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'update_passenger_request.g.dart';

@JsonSerializable()
class UpdatePassengerRequestBody {
  String Email;
  String Phone;
  String Name;
  String? AccountId;
  bool Gender;

  UpdatePassengerRequestBody(
      {required this.Email,
      required this.Phone,
      required this.Gender,
      required this.Name,
      this.AccountId});

  factory UpdatePassengerRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdatePassengerRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePassengerRequestBodyToJson(this);
}
