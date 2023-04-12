import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../data/common/google_map.dart';

class FindTransportationController extends GetxController {
  var lifeCycleController = Get.find<LifeCycleController>();

  Rx<double> scrollPosition = 0.0.obs;
  var position = {}.obs;
  var showMap = false.obs;
  var isLoading = false.obs;
  Maps map = Maps();
  ScrollController scrollController = ScrollController(initialScrollOffset: 1);

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    scrollController.addListener(() {
      scrollPosition.value = scrollController.position.pixels;
    });
    await map.determinePosition();
    if (map.permission == LocationPermission.whileInUse ||
        map.permission == LocationPermission.always) {
      position.value = await map.getCurrentPosition();
    }
    isLoading.value = false;
  }
}
