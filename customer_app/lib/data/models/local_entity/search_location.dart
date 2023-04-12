
import 'package:customer_app/data/models/local_entity/location.dart';

class SearchLocation {
  String? id;
  String? name;
  String? address;
  Location? location;
  List<String>? types;

  SearchLocation({this.id, this.name, this.address, this.location, this.types});

  SearchLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    if (location != null) {
      data['location'] = location?.toJson();
    }
    data['types'] = types;
    return data;
  }
}
