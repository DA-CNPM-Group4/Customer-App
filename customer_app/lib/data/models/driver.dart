class Driver {
  String? address;
  String? driverCitizenId;
  String? gender;
  String? phone;
  int? driverId;
  String? email;
  String? username;
  String? driverLicenseId;
  List<VehicleList>? vehicleList;
  Position? position;
  String? fullname;

  Driver(
      {this.address,
        this.driverCitizenId,
        this.gender,
        this.phone,
        this.driverId,
        this.email,
        this.username,
        this.driverLicenseId,
        this.vehicleList,
        this.position,
        this.fullname});

  Driver.fromJson(Map<dynamic, dynamic> json) {
    address = json['address'];
    driverCitizenId = json['driverCitizenId'];
    gender = json['gender'];
    phone = json['phone'];
    driverId = json['driverId'];
    email = json['email'];
    username = json['username'];
    driverLicenseId = json['driverLicenseId'];
    if (json['vehicleList'] != null) {
      vehicleList = <VehicleList>[];
      json['vehicleList'].forEach((v) {
        vehicleList!.add(VehicleList.fromJson(v));
      });
    }
    position = json['position'] != null
        ? new Position.fromJson(json['position'])
        : null;
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['driverCitizenId'] = this.driverCitizenId;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['driverId'] = this.driverId;
    data['email'] = this.email;
    data['username'] = this.username;
    data['driverLicenseId'] = this.driverLicenseId;
    if (this.vehicleList != null) {
      data['vehicleList'] = this.vehicleList!.map((v) => v.toJson()).toList();
    }
    if (this.position != null) {
      data['position'] = this.position!.toJson();
    }
    data['fullname'] = this.fullname;
    return data;
  }
}

class VehicleList {
  String? licensePlateNum;
  String? typeOfVehicle;
  String? brand;
  String? ownername;
  int? driverId;

  VehicleList(
      {this.licensePlateNum,
        this.typeOfVehicle,
        this.brand,
        this.ownername,
        this.driverId});

  VehicleList.fromJson(Map<dynamic, dynamic> json) {
    licensePlateNum = json['licensePlateNum'];
    typeOfVehicle = json['typeOfVehicle'];
    brand = json['brand'];
    ownername = json['ownername'];
    driverId = json['driverId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['licensePlateNum'] = this.licensePlateNum;
    data['typeOfVehicle'] = this.typeOfVehicle;
    data['brand'] = this.brand;
    data['ownername'] = this.ownername;
    data['driverId'] = this.driverId;
    return data;
  }
}

class Position {
  double? latitude;
  double? longitude;

  Position({this.latitude, this.longitude});

  Position.fromJson(Map<dynamic, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}