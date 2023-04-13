import 'package:customer_app/data/services/device_location_service.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindTransportationController extends GetxController {
  var lifeCycleController = Get.find<LifeCycleController>();

  Rx<double> scrollPosition = 0.0.obs;
  var position = {}.obs;
  var showMap = false.obs;
  var isLoading = false.obs;
  ScrollController scrollController = ScrollController(initialScrollOffset: 1);

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    scrollController.addListener(() {
      scrollPosition.value = scrollController.position.pixels;
    });

    position.value =
        await DeviceLocationService.instance.getCurrentPositionAsMap();

    isLoading.value = false;
  }
}
