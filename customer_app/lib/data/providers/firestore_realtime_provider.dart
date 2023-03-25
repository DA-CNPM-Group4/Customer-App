import 'package:firebase_database/firebase_database.dart';

class FirestoreRealtimeProvider {
  // make this nullable by adding '?'
  static FirestoreRealtimeProvider? _instance;

  static FirestoreRealtimeProvider get instance {
    return _instance ??= FirestoreRealtimeProvider._();
  }

  factory FirestoreRealtimeProvider() {
    _instance ??= FirestoreRealtimeProvider._();
    // since you are sure you will return non-null value, add '!' operator
    return _instance!;
  }

  late FirebaseDatabase database;
  late DatabaseReference onlDriversRef;
  late DatabaseReference requestsRef;

  FirestoreRealtimeProvider._() {
    database = FirebaseDatabase.instance;
    onlDriversRef = database.ref(FirebaseRealtimePaths.DRIVERS);
    requestsRef = database.ref(FirebaseRealtimePaths.REQUESTS);
    // initialization and stuff
  }

  DatabaseReference driverNodeReferences(String driverId) {
    return database.ref('${FirebaseRealtimePaths.DRIVERS}/$driverId');
  }
}

abstract class FirebaseRealtimePaths {
  FirebaseRealtimePaths._();
  static const DRIVERS = 'drivers';
  static const TRIPS = 'trips';
  static const REQUESTS = 'requests';
  static const PASSENGERS = 'passengers';
}
