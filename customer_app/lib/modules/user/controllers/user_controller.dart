import 'dart:async';

import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/modules/user/controllers/wallet.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/modules/user/controllers/user_settings.dart';
import 'package:customer_app/modules/utils/widgets.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  LifeCycleController lifeCycleController = Get.find<LifeCycleController>();
  late List<UserSettings> settings;
  List<String> header = ["Account"];
  late Rxn<UserEntity>? rxPassenger;

  var isLoading = false.obs;
  Wallet? wallet;
  var isClicked = false.obs;
  var error = ''.obs;
  var buttonLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    settings = [
      UserSettings(
        name: "Booking History",
        icons: "assets/icons/my_orders.png",
        page: Routes.TRIP_INFO,
        ontap: () {
          Get.toNamed(Routes.TRIP_INFO);
        },
      ),
      UserSettings(
        name: "Change Password",
        icons: "assets/icons/my_orders.png",
        page: Routes.CHANGE_PASSWORD,
        ontap: () async {
          await goToChangePasswordView();
        },
      ),
      UserSettings(
        name: "Log out",
        icons: "assets/icons/log_out.jpeg",
        page: Routes.WELCOME,
        ontap: () async {
          await lifeCycleController.logout();
        },
      ),
    ];
    isLoading.value = true;
    rxPassenger = await lifeCycleController.getRxPassenger;
    isLoading.value = false;
  }

  void goToProfileView() {
    Get.toNamed(Routes.EDIT_PROFILE);
  }

  Future<void> goToChangePasswordView() async {
    if (lifeCycleController.isloginByGoogle == true) {
      showSnackBar("Failed", "You are login by google account");
      return;
    }
    Get.toNamed(Routes.CHANGE_PASSWORD);
  }
}
