import 'package:json_annotation/json_annotation.dart';
part 'register_request_2.g.dart';

@JsonSerializable()
class RegisterRequestBodyV2 {
  String email;
  String phone;
  String password;
  String role = "Passenger";
  bool gender;
  String name;
  String mode;

  RegisterRequestBodyV2(
      {required this.email,
      required this.phone,
      required this.password,
      required this.role,
      required this.name,
      required this.gender,
      this.mode = "2"});

  factory RegisterRequestBodyV2.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestBodyV2FromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestBodyV2ToJson(this);
}
