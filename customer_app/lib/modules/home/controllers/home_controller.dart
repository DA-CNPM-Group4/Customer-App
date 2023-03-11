import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  List<String> banners = [
    "assets/main_banner/1.png",
    "assets/main_banner/2.png",
    "assets/main_banner/3.png",
  ];

  List<String> banners_2 = [
    "assets/main_banner_2/1.PNG",
    "assets/main_banner_2/2.PNG",
    "assets/main_banner_2/3.PNG",
    "assets/main_banner_2/4.PNG",
    "assets/main_banner_2/5.PNG",
    "assets/main_banner_2/6.PNG"
  ];
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
