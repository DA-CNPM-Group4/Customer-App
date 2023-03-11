import 'package:get/get.dart';

import '../controllers/password_login_controller.dart';

class PasswordLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordLoginController>(
      () => PasswordLoginController(),
    );
  }
}
