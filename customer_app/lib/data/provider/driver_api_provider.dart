import 'package:customer_app/data/common/api_handler.dart';
import 'package:customer_app/data/models/requests/create_passenger_request.dart';
import 'package:customer_app/data/models/requests/login_request.dart';
import 'package:customer_app/data/models/requests/register_request.dart';

class PassengerAPIProvider {
  static Future<void> login({required LoginRequestBody body}) async {
    var response = await APIHandlerImp.instance
        .post(body.toJson(), '/Authentication/Login');

    if (response.data["status"]) {
      await APIHandlerImp.instance
          .storeIdentity(response.data["data"]['accountId']);
    } else {
      return Future.error(response.data['message']);
    }
  }

  static Future<void> register({required RegisterRequestBody body}) async {
    var response = await APIHandlerImp.instance
        .post(body.toJson(), '/Authentication/Register');
    if (response.data["status"]) {
      return;
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

  static Future<void> updatePassenger(
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
}
