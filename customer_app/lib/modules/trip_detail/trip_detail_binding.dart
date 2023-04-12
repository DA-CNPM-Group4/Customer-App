import 'package:customer_app/modules/trip_detail/trip_detail_controller.dart';
import 'package:get/get.dart';

class TripDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripDetailController>(
      () => TripDetailController(),
    );
  }
}
