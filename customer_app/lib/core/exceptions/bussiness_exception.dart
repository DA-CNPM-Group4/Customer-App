import 'package:flutter/cupertino.dart';

class IBussinessException implements Exception {
  const IBussinessException(this.message,
      {this.debugMessage = "unknown message", this.place = "unknown"});

  final String? message;
  final String? debugMessage;
  final String? place;

  @override
  String toString() {
    String result = message ?? 'Bussiness Logic Exception';
    if (debugMessage is String) {
      debugPrint('$place: $debugMessage');
    }
    return result;
  }
}

class TripNotFoundException extends IBussinessException {
  const TripNotFoundException(String tripId,
      {String? message = "Trip Not Found", String? place})
      : super(message, debugMessage: "Trip $tripId not found", place: place);
}

class AccountNotActiveException extends IBussinessException {
  const AccountNotActiveException(String accountId,
      {String? message = "Account Not Activate", String? place})
      : super(message,
            debugMessage: "This $accountId not active", place: place);
}

class CancelActionException extends IBussinessException {
  const CancelActionException(
      {String? message = "Cancel action", String? debugMessage, String? place})
      : super(message, debugMessage: debugMessage, place: place);
}

class PassengerNotFoundException extends IBussinessException {
  const PassengerNotFoundException(
      {String? message = "Passenger Not Found",
      String? debugMessage,
      String? place})
      : super(message, debugMessage: debugMessage, place: place);
}
