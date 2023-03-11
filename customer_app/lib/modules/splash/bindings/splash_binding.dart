import 'package:get/get.dart';

import '../../welcome/controllers/welcome_controller.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut(()=>WelcomeController());
  }
}
