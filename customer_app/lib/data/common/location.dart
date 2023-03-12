
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  double? lng;
  double? lat;
  String? address;

  Location({this.lng, this.lat,this.address});

  Location.fromJson(Map<String, dynamic> json) {
    lng = json['lng'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lng'] = lng;
    data['lat'] = lat;
    return data;
  }

  void setLocation(LatLng lg){
    lat = lg.latitude;
    lng = lg.longitude;
  }
}