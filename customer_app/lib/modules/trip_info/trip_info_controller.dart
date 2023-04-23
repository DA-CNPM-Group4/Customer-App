import 'package:customer_app/data/models/requests/trip_response.dart';
import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/data/services/rest/passenger_api_service.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/modules/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripInfoController extends GetxController {
  final LifeCycleController lifeCycleController =
      Get.find<LifeCycleController>();

  late UserEntity userEntity;

  RxBool isLoading = false.obs;
  final bookedList = <TripResponse>[].obs;

  RxBool isLoadMore = false.obs;
  final int pageSize = 1;
  late final int maxPage;
  int currentPage = 1;

  @override
  void onInit() async {
    userEntity = await lifeCycleController.getPassenger;

    isLoading.value = true;

    await _getTotalPageSize();
    await _loadinitialTrip();

    isLoading.value = false;
    super.onInit();
  }

  Future<void> _loadinitialTrip() async {
    try {
      // bookedList.value = await DriverAPIService.tripApi.getDriverTrips();
      if (currentPage > maxPage) return;
      bookedList.value = await PassengerAPIService.tripApi
          .getPassengerTripsPaging(pageNum: currentPage, pageSize: pageSize);
    } catch (e) {
      showSnackBar("Error", "Failed to fetch trips history");
    }
  }

  Future<void> _getTotalPageSize() async {
    try {
      maxPage = await PassengerAPIService.tripApi
          .getPassengerTripsTotalPage(pageSize: pageSize);
      debugPrint("Max Page: ${maxPage.toString()}");
    } catch (e) {
      maxPage = 1;
      debugPrint(e.toString());
    }
  }

  loadMoreTrip() async {
    if (currentPage >= maxPage) {
      return;
    }
    try {
      isLoadMore.value = true;
      currentPage++;
      final newTrips = await PassengerAPIService.tripApi
          .getPassengerTripsPaging(pageSize: pageSize, pageNum: currentPage);
      bookedList.addAll(newTrips);
    } catch (e) {
      currentPage--;
      debugPrint(e.toString());
      showSnackBar("Failed", "Failed to load more trip");
    } finally {
      isLoadMore.value = false;
    }
  }
}
