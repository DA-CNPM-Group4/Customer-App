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
      print('$place: $debugMessage');
    }
    return result;
  }
}

class TripNotFoundException extends IBussinessException {
  const TripNotFoundException(String tripId,
      {String? message = "Trip Not Found", String? place})
      : super(message, debugMessage: "Trip $tripId not found", place: place);
}

class PassengerNotFoundException extends IBussinessException {
  const PassengerNotFoundException(
      {String? message = "Passenger Not Found",
      String? debugMessage,
      String? place})
      : super(message, debugMessage: debugMessage, place: place);
}
