import 'package:customer_app/data/models/requests/trip_response.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripDetailController extends GetxController {
  final LifeCycleController lifeCycleController =
      Get.find<LifeCycleController>();

  bool isLoading = false;
  bool isLoadMore = false;
  ScrollController scrollController = ScrollController();
  final List<TripResponse> bookedList = [
    // To test empty bookedList, just comment the below code
    TripResponse(
      tripId: "1",
      requestId: "1",
      driverId: "1",
      passengerId: "1",
      staffId: "1",
      vehicleId: "1",
      createdTime: DateTime.now(),
      destination: "1",
      latDesAddr: 1,
      longDesAddr: 1,
      startAddress: "1",
      latStartAddr: 1,
      longStartAddr: 1,
      tripStatus: "1",
      distance: 1,
      price: 1,
      vehicleType: "1",
      timeSecond: 1,
    ),
    TripResponse(
      tripId: "1",
      requestId: "1",
      driverId: "1",
      passengerId: "1",
      staffId: "1",
      vehicleId: "1",
      createdTime: DateTime.now(),
      destination: "1",
      latDesAddr: 1,
      longDesAddr: 1,
      startAddress: "1",
      latStartAddr: 1,
      longStartAddr: 1,
      tripStatus: "1",
      distance: 1,
      price: 1,
      vehicleType: "1",
      timeSecond: 1,
    ),
  ];
}
