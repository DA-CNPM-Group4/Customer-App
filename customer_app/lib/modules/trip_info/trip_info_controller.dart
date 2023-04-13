import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/data/models/requests/trip_response.dart';
import 'package:customer_app/data/services/rest/passenger_api_service.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripInfoController extends GetxController {
  final LifeCycleController lifeCycleController =
      Get.find<LifeCycleController>();

  late UserEntity userEntity;

  RxBool isLoading = false.obs;
  RxBool isLoadMore = false.obs;
  ScrollController scrollController = ScrollController();
  final bookedList = <TripResponse>[].obs;

  @override
  void onInit() async {
    super.onInit();
    userEntity = await lifeCycleController.getPassenger;
    isLoading.value = true;
    bookedList.value = await PassengerAPIService.tripApi.getPassengerTrips();

    isLoading.value = false;
  }
}
