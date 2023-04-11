// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'realtime_trip.g.dart';

@JsonSerializable()
class RealtimeTripRequest {
  String CreatedTime;
  String Destination;
  double Distance;
  String? DriverId;
  String? PassengerId;
  String StaffId = "00000000-0000-0000-0000-000000000000";

  double LatDesAddr;
  double LongDesAddr;

  String StartAddress;
  double LatStartAddr;
  double LongStartAddr;

  String? TripId;
  String? TripStatus;

  String? VehicleId;
  String? VehicleType;

  RealtimeTripRequest(
      {required this.CreatedTime,
      required this.DriverId,
      required this.Distance,
      required this.Destination,
      required this.LatDesAddr,
      required this.LongDesAddr,
      required this.StartAddress,
      required this.LatStartAddr,
      required this.LongStartAddr,
      required this.VehicleType,
      required this.VehicleId,
      required this.PassengerId,
      required this.StaffId,
      required this.TripId,
      required this.TripStatus});

  factory RealtimeTripRequest.fromJson(Map<String, dynamic> json) =>
      _$RealtimeTripRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RealtimeTripRequestToJson(this);
}
