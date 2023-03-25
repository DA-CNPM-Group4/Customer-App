import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/data/models/requests/create_passenger_request.dart';
import 'package:customer_app/data/models/requests/create_triprequest_request.dart';
import 'package:customer_app/data/models/requests/get_passenger_request.dart';
import 'package:customer_app/data/models/requests/login_request.dart';
import 'package:customer_app/data/models/requests/register_request.dart';
import 'package:customer_app/data/providers/api_provider.dart';
import 'package:customer_app/data/services/general_api_service.dart';
import 'package:customer_app/data/services/trip_api_service.dart';
import 'package:customer_app/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PassengerAPIService {
  static GeneralAPIService authApi = GeneralAPIService();
  static TripApiService tripApi = TripApiService();

  static Future<void> createPassenger(
      {required CreatePassengerRequestBody body}) async {
    var identity = await APIHandlerImp.instance.getIdentity();
    body.AccountId = identity;
    var response = await APIHandlerImp.instance
        .post(body.toJson(), '/Info/Passenger/AddInfo');
    if (response.data["status"]) {
      return;
    } else {
      return Future.error(response.data['message']);
    }
  }

  static Future<UserEntity> getPassengerInfo() async {
    var identity = await APIHandlerImp.instance.getIdentity();
    var body = {"accountId": identity};

    var response = await APIHandlerImp.instance
        .post(body, '/Info/Passenger/GetPassengerInfoById');
    if (response.data["status"]) {
      var user = UserEntity.fromJson(response.data['data']);
      return user;
    } else {
      return Future.error(response.data['message']);
    }
  }

  static Future<void> updatePassenger(
      {required CreatePassengerRequestBody body}) async {
    var identity = await APIHandlerImp.instance.getIdentity();
    body.AccountId = identity;

    var response = await APIHandlerImp.instance
        .post(body.toJson(), '/Info/Passenger/UpdateInfo');
    if (response.data["status"]) {
      return;
    } else {
      return Future.error(response.data['message']);
    }
  }
}
