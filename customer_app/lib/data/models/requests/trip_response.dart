import 'package:json_annotation/json_annotation.dart';
part 'trip_response.g.dart';

@JsonSerializable()
class TripResponse {
  String tripId;
  String requestId;
  String driverId;
  String passengerId;
  String staffId;
  String vehicleId;
  String? completeTime;
  DateTime createdTime;
  String destination;
  double latDesAddr;
  double longDesAddr;
  String startAddress;
  double latStartAddr;
  double longStartAddr;
  String tripStatus;
  double distance;
  double price;
  String vehicleType;
  double? timeSecond;

  TripResponse({
    required this.tripId,
    required this.requestId,
    required this.driverId,
    required this.passengerId,
    required this.staffId,
    required this.vehicleId,
    this.completeTime,
    required this.createdTime,
    required this.destination,
    required this.latDesAddr,
    required this.longStartAddr,
    required this.startAddress,
    required this.latStartAddr,
    required this.longDesAddr,
    required this.tripStatus,
    required this.distance,
    required this.price,
    required this.vehicleType,
    this.timeSecond,
  });

  factory TripResponse.fromJson(Map<String, dynamic> json) =>
      _$TripResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TripResponseToJson(this);
}
