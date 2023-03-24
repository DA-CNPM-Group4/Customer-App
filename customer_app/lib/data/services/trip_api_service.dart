import 'package:customer_app/core/exceptions/unexpected_exception.dart';
import 'package:customer_app/data/models/requests/create_triprequest_request.dart';
import 'package:customer_app/data/provider/api_provider.dart';

class TripApiService {
  //  TODO: HANDLE RESPONSE
  static Future<String> getTrip(String tripId) async {
    try {
      var query = {'tripId': tripId};
      var response = await APIHandlerImp.instance
          .get('/Trip/Trip/GetCurrentTrip', query: query);
      if (response.data["status"]) {
        return response.data['data'];
      } else {
        return Future.error(response.data['message']);
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "get-trip-info", debugMessage: e.toString()));
    }
  }

  //  TODO: HANDLE RESPONSE
  static Future<String> getPassengerTrips() async {
    try {
      var passengerId = await APIHandlerImp.instance.getIdentity();
      var query = {'passengerId': passengerId};

      var response = await APIHandlerImp.instance
          .get('/Trip/Trip/GetDriverTrips', query: query);
      if (response.data["status"]) {
        return response.data['data'];
      } else {
        return Future.error(response.data['message']);
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "get-trip-info", debugMessage: e.toString()));
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

  static Future<Map<String, dynamic>> getCurrentTrip(String requestId) async {
    var identity = await APIHandlerImp.instance.getIdentity();

    var query = {'passengerId': identity, "requestId": requestId};
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
