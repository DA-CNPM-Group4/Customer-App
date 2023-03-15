import 'package:json_annotation/json_annotation.dart';
part 'trip_request.g.dart';

@JsonSerializable()
class RealtimeTripRequest {
  String? PassengerId;
  String StaffId = "00000000-0000-0000-0000-000000000000";
  String? RequestStatus = 'FindingDriver';

  String CreatedTime;

  String Destination;
  double LatDesAddr;
  double LongDesAddr;

  String StartAddress;
  double LatStartAddr;
  double LongStartAddr;

  String PassengerNote;
  double Distance;
  String PassengerPhone;
  int Price;
  String VehicleType;

  RealtimeTripRequest(
      {required this.CreatedTime,
      required this.PassengerNote,
      required this.Distance,
      required this.Destination,
      required this.LatDesAddr,
      required this.LongDesAddr,
      required this.StartAddress,
      required this.LatStartAddr,
      required this.LongStartAddr,
      required this.PassengerPhone,
      required this.Price,
      required this.VehicleType});

  factory RealtimeTripRequest.fromJson(Map<String, dynamic> json) =>
      _$RealtimeTripRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RealtimeTripRequestToJson(this);
}
