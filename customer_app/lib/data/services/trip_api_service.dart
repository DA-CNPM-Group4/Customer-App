import 'package:customer_app/core/exceptions/bussiness_exception.dart';
import 'package:customer_app/core/exceptions/unexpected_exception.dart';
import 'package:customer_app/data/models/requests/create_triprequest_request.dart';
import 'package:customer_app/data/models/requests/trip_response.dart';
import 'package:customer_app/data/providers/api_provider.dart';

class TripApiService {
  Future<TripResponse> getTrip(String tripId) async {
    try {
      var query = {'tripId': tripId};
      var response = await APIHandlerImp.instance
          .get('/Trip/Trip/GetCurrentTrip', query: query);
      if (response.data["status"]) {
        return TripResponse.fromJson(response.data['data']);
      } else {
        return Future.error(response.data['message']);
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "get-trip-info", debugMessage: e.toString()));
    }
  }

  Future<List<TripResponse>> getPassengerTrips() async {
    try {
      var passengerId = await APIHandlerImp.instance.getIdentity();
      var query = {'passengerId': passengerId};

      var response = await APIHandlerImp.instance
          .get('/Trip/Trip/GetDriverTrips', query: query);
      if (response.data["status"]) {
        var listTripJson = response.data['data'] as List;
        return listTripJson
            .map((tripJson) => TripResponse.fromJson(tripJson))
            .toList();
      } else {
        return Future.error(response.data['message']);
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "get-trips-info", debugMessage: e.toString()));
    }
  }

  Future<dynamic> getPrice({required double length}) async {
    var response = await APIHandlerImp.instance
        .get('/Trip/TripRequest/CalculatePrice', query: {'distance': length});
    if (response.data["status"]) {
      return response.data['data'];
    } else {
      return Future.error(response.data['message']);
    }
  }

  Future<String> createRequest({required CreateTripRequestBody body}) async {
    try {
      var identity = await APIHandlerImp.instance.getIdentity();
      body.PassengerId = identity;

      var response = await APIHandlerImp.instance
          .post(body, '/Trip/TripRequest/SendRequest');
      if (response.data["status"]) {
        return response.data['data'];
      } else {
        return Future.error(IBussinessException(response.data['message']));
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "create-trip-request", debugMessage: e.toString()));
    }
  }

  Future<void> cancelRequest({required String requestId}) async {
    try {
      var query = {"requestId": requestId};
      var response = await APIHandlerImp.instance
          .get('/Trip/TripRequest/CancelRequest', query: query);
      if (response.data["status"]) {
      } else {
        return Future.error(IBussinessException(response.data['message']));
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "cancel-trip-request", debugMessage: e.toString()));
    }
  }

  Future<Map<String, dynamic>> getCurrentTrip(String requestId) async {
    try {
      var identity = await APIHandlerImp.instance.getIdentity();

      var query = {'passengerId': identity, "requestId": requestId};
      var response = await APIHandlerImp.instance.get(
        '/Trip/Trip/GetCurrentTripForPassenger',
        query: query,
      );
      if (response.data["status"]) {
        return response.data['data'];
      } else {
        return Future.error(IBussinessException(response.data['message']));
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "get-current-trip", debugMessage: e.toString()));
    }
  }
}
