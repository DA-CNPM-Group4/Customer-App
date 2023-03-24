
import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponseBody {
  String accessToken;
  String refreshToken;
  String accountId;

  LoginResponseBody({
    required this.accessToken,
    required this.refreshToken,
    required this.accountId,
  });

  factory LoginResponseBody.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseBodyToJson(this);
}
