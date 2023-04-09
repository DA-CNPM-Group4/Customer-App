import 'dart:async';

import 'package:customer_app/Data/models/realtime_models/realtime_passenger.dart';
import 'package:customer_app/data/models/realtime_models/realtime_driver.dart';
import 'package:customer_app/data/models/realtime_models/realtime_location.dart';
import 'package:customer_app/data/models/realtime_models/trip_request.dart';
import 'package:customer_app/data/providers/firesbase_realtime_provider.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRealtimeService {
  static FirebaseRealtimeService? _instance;

  static FirebaseRealtimeService get instance {
    return _instance ??= FirebaseRealtimeService();
  }

  final database = FirebaseDatabase.instance;

  DatabaseReference getDatabaseReference(
      {required String nodeId, required String rootPath}) {
    var ref = database.ref(rootPath).child(nodeId);
    return ref;
  }

  Future<RealtimeDriver?> readDriverNode(
    String driverId,
  ) async {
    var ref = database.ref(FirebaseRealtimePaths.DRIVERS);
    var snapshot = await ref.child(driverId).get();

    if (snapshot.exists) {
      try {
        final json = Map<String, dynamic>.from(snapshot.value as Map);
        var driver = RealtimeDriver.fromMap(json);
        return driver;
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

  Future<RealtimeTripRequest?> readTripNode(
    String tripId,
  ) async {
    var ref = database.ref(FirebaseRealtimePaths.TRIPS);
    var snapshot = await ref.child(tripId).get();

    if (snapshot.exists) {
      try {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        return RealtimeTripRequest.fromJson(data);
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

  Future<void> setPassengerNode(
      {required String passengerId,
      required RealtimePassenger passenger}) async {
    var ref = database.ref(FirebaseRealtimePaths.PASSENGERS).child(passengerId);
    Map<String, dynamic> data = passenger.toJson();
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

  Future<void> updatePassengerNode(
      String passengerId, RealtimeLocation location) async {
    var ref = database
        .ref(FirebaseRealtimePaths.PASSENGERS)
        .child(passengerId)
        .child('location');
    Map<String, dynamic> data = location.toJson();
    await ref.update(data);
  }

  Future<void> deleteDriverNode(String driverId) async {
    var ref = database.ref(FirebaseRealtimePaths.DRIVERS).child(driverId);
    await ref.remove();
  }

  Future<void> deletePassengerNode(String passengerId) async {
    var ref = database.ref(FirebaseRealtimePaths.PASSENGERS).child(passengerId);
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
