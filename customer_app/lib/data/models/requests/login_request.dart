import 'package:json_annotation/json_annotation.dart';
part 'login_request.g.dart';

@JsonSerializable()
class LoginRequestBody {
  String email;
  String phone;
  String password;
  String role;

  LoginRequestBody(
      {required this.email,
      required this.phone,
      required this.password,
      required this.role});

  factory LoginRequestBody.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestBodyToJson(this);
}
