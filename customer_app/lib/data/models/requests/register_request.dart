import 'package:json_annotation/json_annotation.dart';
part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequestBody {
  String email;
  String phone;
  String password;
  String role = "Passenger";
  String name;
  String mode;

  RegisterRequestBody(
      {required this.email,
      required this.phone,
      required this.password,
      required this.role,
      required this.name,
      this.mode = "1"});

  factory RegisterRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestBodyToJson(this);
}
