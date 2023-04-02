import 'package:json_annotation/json_annotation.dart';
part 'rate_trip_request.g.dart';

@JsonSerializable()
class RateTripRequestBody {
  String tripId;
  double rate;
  String? description;

  RateTripRequestBody({
    required this.tripId,
    required this.rate,
    this.description = "",
  });

  factory RateTripRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RateTripRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RateTripRequestBodyToJson(this);
}
