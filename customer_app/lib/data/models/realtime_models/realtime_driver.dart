import 'package:customer_app/data/models/realtime_models/realtime_location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'realtime_driver.g.dart';

@JsonSerializable(explicitToJson: true)
class RealtimeDriver {
  final RealtimeDriverInfo info;
  final RealtimeDriverVehicle vehicle;
  RealtimeLocation location;

  RealtimeDriver(
      {required this.info, required this.vehicle, required this.location});

  factory RealtimeDriver.fromJson(Map<String, dynamic> json) =>
      _$RealtimeDriverFromJson(json);

  Map<String, dynamic> toJson() => _$RealtimeDriverToJson(this);

  factory RealtimeDriver.fromMap(Map data) {
    return RealtimeDriver(
        info: RealtimeDriverInfo.fromMap(data['info']),
        vehicle: RealtimeDriverVehicle.fromMap(data['vehicle']),
        location: RealtimeLocation.fromMap(data['location']));
  }
}

@JsonSerializable()
class RealtimeDriverInfo {
  final String phone;
  final String name;

  RealtimeDriverInfo({required this.phone, required this.name});

  factory RealtimeDriverInfo.fromJson(Map<String, dynamic> json) =>
      _$RealtimeDriverInfoFromJson(json);

  Map<String, dynamic> toJson() => _$RealtimeDriverInfoToJson(this);

  factory RealtimeDriverInfo.fromMap(Map data) {
    return RealtimeDriverInfo(
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

@JsonSerializable()
class RealtimeDriverVehicle {
  final String brand;
  final String name;
  final String vehicleId;

  RealtimeDriverVehicle(
      {required this.brand, required this.name, required this.vehicleId});

  factory RealtimeDriverVehicle.fromJson(Map<String, dynamic> json) =>
      _$RealtimeDriverVehicleFromJson(json);

  Map<String, dynamic> toJson() => _$RealtimeDriverVehicleToJson(this);

  factory RealtimeDriverVehicle.fromMap(Map data) {
    return RealtimeDriverVehicle(
      brand: data['brand'] ?? '',
      name: data['name'] ?? '',
      vehicleId: data['vehicleId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'name': name,
      'vehicleId': vehicleId,
    };
  }
}
