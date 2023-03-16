import 'package:customer_app/data/common/api_handler.dart';
import 'package:customer_app/data/models/requests/create_passenger_request.dart';
import 'package:customer_app/data/models/requests/create_triprequest_request.dart';
import 'package:customer_app/data/models/requests/get_passenger_request.dart';
import 'package:customer_app/data/models/requests/login_request.dart';
import 'package:customer_app/data/models/requests/register_request.dart';
import 'package:customer_app/data/models/user/user_entity.dart';
import 'package:customer_app/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PassengerAPIService {
  static Future<void> login({required LoginRequestBody body}) async {
    var response = await APIHandlerImp.instance
        .post(body.toJson(), '/Authentication/Login');

    if (response.data["status"]) {
      var identity = response.data["data"]['accountId'];
      await APIHandlerImp.instance.storeIdentity(identity);
    } else {
      return Future.error(response.data['message']);
    }
  }

  static Future<void> register({required RegisterRequestBody body}) async {
    var response = await APIHandlerImp.instance
        .post(body.toJson(), '/Authentication/Register');
    if (response.data["status"]) {
      var identity = response.data["data"]['accountId'];

      await APIHandlerImp.instance.storeIdentity(identity);
    } else {
      return Future.error(response.data['message']);
    }
  }

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
    var body = GetPassengerRequestBody(accountId: identity);

    var response = await APIHandlerImp.instance
        .post(body.toJson(), '/Info/Passenger/GetPassengerInfoById');
    if (response.data["status"]) {
      var data = response.data['data'];
      var user = UserEntity.fromJson(data);
      box = await Hive.openBox("box");
      await box.put("user", user);
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

  static Future<dynamic> getPrice({required double length}) async {
    var response = await APIHandlerImp.instance
        .get('/Trip/TripRequest/CalculatePrice', query: {'distance': length});
    if (response.data["status"]) {
      return response.data['data'];
    } else {
      return Future.error(response.data['message']);
    }
  }

// return requestId
  static Future<String> createRequest(
      {required CreateTripRequestBody body}) async {
    var identity = await APIHandlerImp.instance.getIdentity();
    body.PassengerId = identity;

    var response = await APIHandlerImp.instance
        .post(body, '/Trip/TripRequest/SendRequest');
    if (response.data["status"]) {
      return response.data['data'];
    } else {
      return Future.error(response.data['message']);
    }
  }

  static Future<Map<String, dynamic>> getCurrentTrip() async {
    var identity = await APIHandlerImp.instance.getIdentity();

    var query = {'passengerId': identity};
    var response = await APIHandlerImp.instance.get(
      '/Trip/Trip/GetCurrentTripForPassenger',
      query: query,
    );
    if (response.data["status"]) {
      return response.data['data'];
    } else {
      return Future.error(response.data['message']);
    }
  }
}
