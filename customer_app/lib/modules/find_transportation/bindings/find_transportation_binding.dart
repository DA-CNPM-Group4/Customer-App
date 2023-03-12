import 'package:get/get.dart';

import '../controllers/find_transportation_controller.dart';

class FindTransportationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindTransportationController>(
      () => FindTransportationController(),
    );
  }
}
