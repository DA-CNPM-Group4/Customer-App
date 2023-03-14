import 'package:json_annotation/json_annotation.dart';
part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequestBody {
  String email;
  String phone;
  String password;
  String role;
  String name;

  RegisterRequestBody(
      {required this.email,
      required this.phone,
      required this.password,
      required this.role,
      required this.name});

  factory RegisterRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestBodyToJson(this);
}
