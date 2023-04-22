import 'package:customer_app/core/exceptions/bussiness_exception.dart';
import 'package:customer_app/core/exceptions/unexpected_exception.dart';
import 'package:customer_app/data/models/requests/create_triprequest_request.dart';
import 'package:customer_app/data/models/requests/rate_trip_request.dart';
import 'package:customer_app/data/models/requests/rate_trip_response.dart';
import 'package:customer_app/data/models/requests/trip_response.dart';
import 'package:customer_app/data/providers/api_provider.dart';

class TripApiService {
  Future<TripResponse> getTrip(String tripId) async {
    try {
      var body = {'tripId': tripId};
      var response = await APIHandlerImp.instance
          .get('/Trip/Trip/GetCurrentTrip', body: body);
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
      var body = {'passengerId': passengerId};

      var response = await APIHandlerImp.instance
          .get('/Trip/Trip/GetPassengerTrips', body: body);
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
      var body = {"requestId": requestId};
      var response = await APIHandlerImp.instance.post(
        body,
        '/Trip/TripRequest/CancelRequest',
      );
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

      var body = {'passengerId': identity, "requestId": requestId};
      var response = await APIHandlerImp.instance.get(
        '/Trip/Trip/GetCurrentTripForPassenger',
        body: body,
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

  Future<void> rateTrip({required RateTripRequestBody requestBody}) async {
    try {
      var response = await APIHandlerImp.instance
          .post(requestBody, '/Trip/TripFeedback/RateTrip');
      if (response.data["status"]) {
      } else {
        return Future.error(IBussinessException(response.data['message']));
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "rate-trip-request", debugMessage: e.toString()));
    }
  }

  Future<RateTripResponse> getTripFeedBack({required String tripId}) async {
    try {
      final requestBody = {'tripId': tripId};
      var response = await APIHandlerImp.instance
          .get('/Trip/TripFeedback/GetTripFeedback', body: requestBody);
      if (response.data["status"]) {
        return RateTripResponse.fromJson(response.data['data']);
      } else {
        return Future.error(
          IBussinessException(
            response.data['message'],
            place: "Get-Trip-Feedback",
            debugMessage: response.data['message'],
          ),
        );
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "get-feedback-request", debugMessage: e.toString()));
    }
  }

  Future<List<TripResponse>> getPassengerTripsPaging(
      {required int pageSize, required int pageNum}) async {
    try {
      var passengerId = await APIHandlerImp.instance.getIdentity();
      var requestBody = {
        "passengerId": passengerId,
        "pageSize": pageSize,
        "pageNum": pageNum,
      };
      var response = await APIHandlerImp.instance.get(
        '/Trip/Trip/GetPassengersTripPaging',
        body: requestBody,
      );
      if (response.data["status"]) {
        var listTripJson = response.data['data'] as List;
        return listTripJson
            .map((tripJson) => TripResponse.fromJson(tripJson))
            .toList();
      } else {
        return Future.error(IBussinessException(
          response.data['message'],
          place: "getPassengerTripsPaging",
          debugMessage: response.data['message'],
        ));
      }
    } catch (e) {
      return Future.error(
        UnexpectedException(
            context: "api: getPassengerTripsPaging",
            debugMessage: e.toString()),
      );
    }
  }

  Future<int> getPassengerTripsTotalPage({required int pageSize}) async {
    try {
      var passengerId = await APIHandlerImp.instance.getIdentity();
      var requestBody = {
        "driverId": passengerId,
        "pageSize": pageSize,
      };
      var response = await APIHandlerImp.instance.get(
        '/Trip/Trip/GetPassengersTripTotalPages',
        body: requestBody,
      );

      if (response.data["status"]) {
        return response.data['data'];
      } else {
        return Future.error(IBussinessException(
          response.data['message'],
          place: "getPassengerTripsTotalPage",
          debugMessage: response.data['message'],
        ));
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "getPassengerTripsTotalPage", debugMessage: e.toString()));
    }
  }
}
