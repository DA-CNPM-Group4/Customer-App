import 'package:json_annotation/json_annotation.dart';

part 'realtime_location.g.dart';

@JsonSerializable()
class RealtimeLocation {
  final double lat;
  final double long;
  final String address;

  RealtimeLocation(
      {required this.lat, required this.long, required this.address});

  factory RealtimeLocation.fromJson(Map<String, dynamic> json) =>
      _$RealtimeLocationFromJson(json);

  Map<String, dynamic> toJson() => _$RealtimeLocationToJson(this);

  factory RealtimeLocation.fromMap(Map data) {
    return RealtimeLocation(
      lat: data['lat'] ?? 0.0,
      long: data['long'] ?? 0.0,
      address: data['address'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'long': long,
      'address': address,
    };
  }
}
