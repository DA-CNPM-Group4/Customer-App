import 'package:customer_app/modules/search_page/controllers/search_page_controller.dart';
import 'package:get/get.dart';
import '../controllers/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(
      () => MapController(),
    );
    Get.lazyPut<SearchPageController>(
      () => SearchPageController(),
    );
  }
}
