import 'dart:async';

import 'package:customer_app/data/common/util.dart';
import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/data/providers/api_provider.dart';
import 'package:customer_app/data/services/passenger_api_provider.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../data/models/user_settings.dart';
import '../../../data/models/wallet.dart';
import '../../../routes/app_pages.dart';

class UserController extends GetxController {
  LifeCycleController lifeCycleController = Get.find<LifeCycleController>();

  UserEntity? user;
  var isLoading = false.obs;
  Wallet? wallet;
  var isClicked = false.obs;
  var start = 30.obs;
  Timer? timer;
  var error = ''.obs;
  var buttonLoading = false.obs;

  List<String> header = ["Account"];
  List<UserSettings> settings = [
    UserSettings(
        name: "My Orders",
        icons: "assets/icons/my_orders.png",
        page: Routes.HOME),
    UserSettings(
        name: "Payment methods",
        icons: "assets/icons/my_orders.png",
        page: Routes.HOME),
    UserSettings(
        name: "Change Password",
        icons: "assets/icons/my_orders.png",
        page: Routes.CHANGE_PASSWORD),
    UserSettings(
        name: "My Orders",
        icons: "assets/icons/my_orders.png",
        page: Routes.HOME),
    UserSettings(
        name: "My Orders",
        icons: "assets/icons/my_orders.png",
        page: Routes.HOME),
    UserSettings(
        name: "My Orders",
        icons: "assets/icons/my_orders.png",
        page: Routes.HOME),
    UserSettings(
        name: "Log out",
        icons: "assets/icons/log_out.jpeg",
        page: Routes.WELCOME),
  ];

  @override
  void onInit() async {
    isLoading.value = true;
    await init();
    isLoading.value = false;
  }

  Future<void> init() async {
    if (lifeCycleController.passenger == null) {
      await getUserData();
    }
    user = lifeCycleController.passenger;
    // await getWallet();
  }

  @override
  void onClose() async {
    super.onClose();
  }

  Future<void> getUserData() async {
    isLoading.value = true;
    try {
      lifeCycleController.passenger =
          await PassengerAPIService.getPassengerInfo();
    } catch (e) {
      showSnackBar("Error: ", "Something wrong ${e.toString()}");
    }
    isLoading.value = false;
  }

  Future<void> getWallet() async {
    isLoading.value = true;
    var response_1 = await APIHandlerImp.instance.get("user/getWallet");
    wallet = Wallet.fromJson(response_1.data["data"]);
    isLoading.value = false;
  }

  sendOTP() async {
    var response = await APIHandlerImp.instance
        .put({"username": lifeCycleController.passenger?.phone}, "sendOTP");
  }

  validateOTP(TextEditingController otpController,
      TextEditingController moneyController, bool type) async {
    buttonLoading.value = true;
    var response = await APIHandlerImp.instance.put({
      "username": lifeCycleController.passenger?.phone,
      "otp": otpController.text
    }, "validateOTP");
    if (response.data["status"]) {
      var response_1 = await APIHandlerImp.instance.put(
          {"money": moneyController.text},
          type ? "user/recharge" : "user/withdraw");
      if (response_1.data["status"]) {
        isLoading.value = true;
        if (type) {
          wallet!.balance =
              wallet!.balance! + double.parse(moneyController.text);
        } else {
          wallet!.balance =
              wallet!.balance! - double.parse(moneyController.text);
        }
        Get.back();
        Get.snackbar("Success", "Your order was success",
            backgroundColor: Colors.grey[100]);
        isLoading.value = false;
      }
    } else {
      Get.snackbar(
          "Fail",
          type
              ? "OTP was wrong, try again"
              : double.parse(moneyController.text) > wallet!.balance!
                  ? "Balance is inefficient"
                  : "OTP was wrong, try again",
          backgroundColor: Colors.grey[100]);
    }
    buttonLoading.value = false;
  }

  void goToProfileView() {
    Get.toNamed(Routes.EDIT_PROFILE);
  }

  void goToChangePasswordView() {
    Get.toNamed(Routes.CHANGE_PASSWORD);
  }

  Future<void> startTimer() async {
    isClicked.value = true;
    const oneSec = Duration(seconds: 1);
    await sendOTP();
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          start.value = 30;
          isClicked.value = false;
          timer.cancel();
        } else {
          start.value -= 1;
        }
      },
    );
  }
}
