import 'dart:async';

import 'package:customer_app/data/common/api_handler.dart';
import 'package:customer_app/data/common/util.dart';
import 'package:customer_app/data/models/user/user_entity.dart';
import 'package:customer_app/data/services/passenger_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../data/models/user_settings.dart';
import '../../../data/models/wallet.dart';
import '../../../routes/app_pages.dart';

class UserController extends GetxController {
  //TODO: Implement UserController
  APIHandlerImp apiHandlerImp = APIHandlerImp();
  var box;
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
    box = await Hive.openBox("box");
    if (box.isOpen) {
      if (!box.containsKey("user")) {
        await getUserData();
      } else {
        user = await box.get("user");
      }
    }
    // await getWallet();
  }

  @override
  void onClose() async {
    super.onClose();
    await box.close();
  }

  void logout() async {
    await box.clear();
    await apiHandlerImp.deleteToken();
  }

  Future<void> getUserData() async {
    isLoading.value = true;
    // var response = await apiHandlerImp.get("user/getInforByToken", {});
    // user = UserEntity.fromJson(response.data["data"]);
    // await box.put("user", user);
    try {
      user = await PassengerAPIService.getPassengerInfo();
    } catch (e) {
      print(e);
      showSnackBar("Error: ", "Something wrong ${e.toString()}");
    }
    isLoading.value = false;
  }

  Future<void> getWallet() async {
    isLoading.value = true;
    var response_1 = await apiHandlerImp.get("user/getWallet");
    wallet = Wallet.fromJson(response_1.data["data"]);
    isLoading.value = false;
  }

  sendOTP() async {
    var response =
        await apiHandlerImp.put({"username": user!.phone!}, "sendOTP");
  }

  validateOTP(TextEditingController otpController,
      TextEditingController moneyController, bool type) async {
    buttonLoading.value = true;
    var response = await apiHandlerImp.put(
        {"username": user!.phone!, "otp": otpController.text}, "validateOTP");
    if (response.data["status"]) {
      var response_1 = await apiHandlerImp.put({"money": moneyController.text},
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
