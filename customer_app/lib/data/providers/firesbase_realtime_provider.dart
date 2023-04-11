import 'package:firebase_database/firebase_database.dart';

class FireBaseRealtimeProvider {
  // make this nullable by adding '?'
  static FireBaseRealtimeProvider? _instance;

  static FireBaseRealtimeProvider get instance {
    return _instance ??= FireBaseRealtimeProvider._();
  }

  factory FireBaseRealtimeProvider() {
    _instance ??= FireBaseRealtimeProvider._();
    // since you are sure you will return non-null value, add '!' operator
    return _instance!;
  }

  late FirebaseDatabase database;
  late DatabaseReference onlDriversRef;
  late DatabaseReference requestsRef;

  FireBaseRealtimeProvider._() {
    database = FirebaseDatabase.instance;
    onlDriversRef = database.ref(FirebaseRealtimePaths.drivers);
    requestsRef = database.ref(FirebaseRealtimePaths.requests);
    // initialization and stuff
  }

  DatabaseReference driverNodeReferences(String driverId) {
    return database.ref('${FirebaseRealtimePaths.drivers}/$driverId');
  }
}

abstract class FirebaseRealtimePaths {
  FirebaseRealtimePaths._();
  static const drivers = 'drivers';
  static const trips = 'trips';
  static const requests = 'requests';
  static const passengers = 'passengers';
}
