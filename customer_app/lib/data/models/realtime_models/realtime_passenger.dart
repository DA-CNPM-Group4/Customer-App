import 'package:customer_app/data/models/realtime_models/realtime_location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'realtime_passenger.g.dart';

@JsonSerializable(explicitToJson: true)
class RealtimePassenger {
  final RealtimePassengerInfo info;
  RealtimeLocation location;

  RealtimePassenger({required this.info, required this.location});

  factory RealtimePassenger.fromJson(Map<String, dynamic> json) =>
      _$RealtimePassengerFromJson(json);

  Map<String, dynamic> toJson() => _$RealtimePassengerToJson(this);

  factory RealtimePassenger.fromMap(Map data) {
    return RealtimePassenger(
        info: RealtimePassengerInfo.fromMap(data['info']),
        location: RealtimeLocation.fromMap(data['location']));
  }
}

@JsonSerializable()
class RealtimePassengerInfo {
  final String phone;
  final String name;

  RealtimePassengerInfo({required this.phone, required this.name});

  factory RealtimePassengerInfo.fromJson(Map<String, dynamic> json) =>
      _$RealtimePassengerInfoFromJson(json);

  Map<String, dynamic> toJson() => _$RealtimePassengerInfoToJson(this);

  factory RealtimePassengerInfo.fromMap(Map data) {
    return RealtimePassengerInfo(
      name: data['name'] ?? '',
      phone: data['phone'] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'name': name,
    };
  }
}
