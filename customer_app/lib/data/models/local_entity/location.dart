import 'package:customer_app/data/services/device_location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  double? lng;
  double? lat;
  String? address;

  Location({this.lng, this.lat, this.address});

  void setLocation(LatLng lg) {
    lat = lg.latitude;
    lng = lg.longitude;
  }

  void setLocationFromPosition(Position position) async {
    lat = position.latitude;
    lng = position.longitude;

    address = await DeviceLocationService.instance.getAddressFromLatLang(
        latitude: position.latitude, longitude: position.longitude);
  }

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  factory Location.fromGeoPosition(Position position) =>
      Location()..setLocationFromPosition(position);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
