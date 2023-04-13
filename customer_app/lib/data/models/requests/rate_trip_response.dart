import 'package:json_annotation/json_annotation.dart';
part 'rate_trip_response.g.dart';

@JsonSerializable()
class RateTripResponse {
  String tripId;
  double rate;
  String note;

  RateTripResponse({
    required this.tripId,
    required this.rate,
    this.note = "",
  });

  factory RateTripResponse.fromJson(Map<String, dynamic> json) =>
      _$RateTripResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RateTripResponseToJson(this);
}
