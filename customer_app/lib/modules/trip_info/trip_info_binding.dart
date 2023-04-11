import 'package:customer_app/modules/trip_info/trip_info_controller.dart';
import 'package:get/get.dart';

class TripInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripInfoController>(
      () => TripInfoController(),
    );
  }
}
