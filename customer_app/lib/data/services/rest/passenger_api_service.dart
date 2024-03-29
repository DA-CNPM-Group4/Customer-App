import 'package:customer_app/core/exceptions/bussiness_exception.dart';
import 'package:customer_app/core/exceptions/unexpected_exception.dart';
import 'package:customer_app/data/models/local_entity/driver_entity.dart';
import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/data/models/requests/create_passenger_request.dart';
import 'package:customer_app/data/models/requests/update_passenger_request.dart';
import 'package:customer_app/data/providers/api_provider.dart';
import 'package:customer_app/data/services/rest/chat_api_service.dart';
import 'package:customer_app/data/services/rest/general_api_service.dart';
import 'package:customer_app/data/services/rest/trip_api_service.dart';

class PassengerAPIService {
  static GeneralAPIService authApi = GeneralAPIService();
  static TripApiService tripApi = TripApiService();
  static ChatAPIService chatApi = ChatAPIService();

  static Future<void> createPassenger(
      {required CreatePassengerRequestBody body}) async {
    try {
      var identity = await APIHandlerImp.instance.getIdentity();
      body.AccountId = identity;
      var response = await APIHandlerImp.instance.post(
        body.toJson(),
        '/Info/Passenger/AddInfo',
        useToken: true,
      );
      if (response.data["status"]) {
        return;
      } else {
        return Future.error(IBussinessException(response.data['message']));
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "create-pasenger-info", debugMessage: e.toString()));
    }
  }

  static Future<UserEntity> getPassengerInfo() async {
    try {
      var identity = await APIHandlerImp.instance.getIdentity();
      var body = {"accountId": identity};

      var response = await APIHandlerImp.instance.post(
        body,
        '/Info/Passenger/GetPassengerInfoById',
        useToken: true,
      );
      if (response.data["status"]) {
        var user = UserEntity.fromJson(response.data['data']);
        return user;
      } else {
        return Future.error(IBussinessException(response.data['message']));
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "get-pasenger-info", debugMessage: e.toString()));
    }
  }

  static Future<void> updatePassenger(
      {required UpdatePassengerRequestBody body}) async {
    try {
      var identity = await APIHandlerImp.instance.getIdentity();
      body.AccountId = identity;

      var response = await APIHandlerImp.instance.post(
        body.toJson(),
        '/Info/Passenger/UpdateInfo',
        useToken: true,
      );
      if (response.data["status"]) {
        return;
      } else {
        return Future.error(IBussinessException(response.data['message']));
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "update-pasenger-info", debugMessage: e.toString()));
    }
  }

  static Future<DriverEntity> getDriverInfo({required String driverId}) async {
    try {
      var body = {'accountId': driverId};
      var response = await APIHandlerImp.instance.post(
        body,
        '/Info/Driver/GetDriverInfoById',
        useToken: true,
      );
      if (!response.data["status"]) {
        if (response.data['data'] == null) {
          return Future.error(IBussinessException(response.data['message']));
        }
        return DriverEntity.fromJson(response.data["data"]);
      } else {
        return Future.error(IBussinessException(response.data['message']));
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "get-driver-info", debugMessage: e.toString()));
    }
  }
}
