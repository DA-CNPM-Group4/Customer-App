import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  List<String> banners = [
    "assets/images/main_banner.png",
    "assets/images/main_banner2.jpeg",
    "assets/images/main_banner3.jpeg",
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
