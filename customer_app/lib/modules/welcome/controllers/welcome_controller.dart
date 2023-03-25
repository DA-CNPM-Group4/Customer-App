import 'package:get/get.dart';

class WelcomeController extends GetxController {
  //TODO: Implement HomeController
  List<String> banners = [
    "assets/imag/banner1.png",
    "assets/banner2.png",
    "assets/banner3.png",
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
