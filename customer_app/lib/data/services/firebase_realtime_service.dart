import 'package:customer_app/data/provider/firestore_realtime_provider.dart';
import 'package:customer_app/Data/models/realtime_models/realtime_driver.dart';
import 'package:customer_app/Data/models/realtime_models/realtime_location.dart';
import 'package:customer_app/Data/models/realtime_models/realtime_passenger.dart';
import 'package:firebase_database/firebase_database.dart';

class FirestoreRealtimeService {
  static FirestoreRealtimeService? _instance;

  static FirestoreRealtimeService get instance {
    return _instance ??= FirestoreRealtimeService();
  }

  final database = FirebaseDatabase.instance;

  Future<RealtimeDriver?> readDriverNode(
    String driverId,
  ) async {
    var ref = database.ref(FirebaseRealtimePaths.DRIVERS);
    var snapshot = await ref.child(driverId).get();

    if (snapshot.exists) {
      try {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        return RealtimeDriver.fromMap(data);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<RealtimePassenger?> readPassengerNode(
    String passengerId,
  ) async {
    var ref = database.ref(FirebaseRealtimePaths.PASSENGERS);
    var snapshot = await ref.child(passengerId).get();

    if (snapshot.exists) {
      try {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        return RealtimePassenger.fromMap(data);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<void> setDriverNode(String driverId, RealtimeDriver driver) async {
    var ref = database.ref(FirebaseRealtimePaths.DRIVERS).child(driverId);
    Map<String, dynamic> data = driver.toJson();
    await ref.set(data);
  }

  Future<void> updateDriverLocationNode(
      String driverId, RealtimeLocation location) async {
    var ref = database
        .ref(FirebaseRealtimePaths.DRIVERS)
        .child(driverId)
        .child('location');
    Map<String, dynamic> data = location.toJson();
    await ref.update(data);
  }

  Future<void> deleteDriverNode(String driverId) async {
    var ref = database.ref(FirebaseRealtimePaths.DRIVERS).child(driverId);
    await ref.remove();
  }

  Future<void> listenDriverNode(
    String driverId,
    Function(DatabaseEvent) callback,
  ) async {
    var ref = database.ref(FirebaseRealtimePaths.DRIVERS).child(driverId);

    ref.onValue.listen((e) {
      callback(e);
    });
  }

  Future<void> listenTripNode(
    String driverId,
    Function(DatabaseEvent) callback,
  ) async {
    var ref = database.ref(FirebaseRealtimePaths.TRIPS);

    ref.onChildAdded.listen((e) {
      callback(e);
    });
  }
}
