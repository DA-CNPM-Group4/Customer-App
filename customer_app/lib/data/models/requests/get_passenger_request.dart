import 'package:json_annotation/json_annotation.dart';
part 'get_passenger_request.g.dart';

@JsonSerializable()
class GetPassengerRequestBody {
  String? accountId;

  GetPassengerRequestBody({this.accountId});

  factory GetPassengerRequestBody.fromJson(Map<String, dynamic> json) =>
      _$GetPassengerRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$GetPassengerRequestBodyToJson(this);
}
