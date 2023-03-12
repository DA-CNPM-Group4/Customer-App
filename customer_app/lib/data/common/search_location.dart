import 'package:customer_app/data/common/location.dart';

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
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['types'] = this.types;
    return data;
  }
}
