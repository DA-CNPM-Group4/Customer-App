import 'dart:async';

import 'package:customer_app/core/exceptions/bussiness_exception.dart';
import 'package:customer_app/data/services/rest/passenger_api_service.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/modules/utils/widgets.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final lifeCycleController = Get.find<LifeCycleController>();

  var isLoading = false.obs;
  var isLoading2 = false.obs;
  var isClicked = true.obs;

  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var start = 15.obs;
  Timer? timer;

  var error = ''.obs;

  Future<void> confirmOTP() async {
    isLoading.value = true;
    final isOTPValid = otpFormKey.currentState!.validate();

    if (!lifeCycleController.isActiveOTP) {
      if (!passwordFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }
    }

    if (!isOTPValid) {
      isLoading.value = false;
      return;
    }
    otpFormKey.currentState?.save();
    passwordFormKey.currentState?.save();

    try {
      if (lifeCycleController.isActiveOTP) {
        await handleActiveAccount();
      } else {
        await handleResetPassword();
      }
    } on IBussinessException catch (e) {
      showSnackBar("Error", e.toString());
    }
    isLoading.value = false;
    return;
  }

  Future<void> handleActiveAccount() async {
    await PassengerAPIService.authApi
        .activeAccountByOTP(lifeCycleController.email, otpController.text);

    await lifeCycleController.getPassengerInfoAndRoutingHome();
  }

  Future<void> handleResetPassword() async {
    await PassengerAPIService.authApi.resetPassword(
        lifeCycleController.email, passwordController.text, otpController.text);
    Get.offAllNamed(Routes.WELCOME);
    showSnackBar("Reset Password", "Reset Password Successfully!");
  }

  Future<void> startTimer() async {
    await handleSendOTP();
    // isClicked.value = true;
    // const oneSec = Duration(seconds: 1);

    // timer = Timer.periodic(
    //   oneSec,
    //   (Timer timer) {
    //     if (start.value == 0) {
    //       start.value = 30;
    //       isClicked.value = false;
    //       timer.cancel();
    //     } else {
    //       start.value -= 1;
    //     }
    //   },
    // );
  }

  Future<void> handleSendOTP() async {
    isLoading2.value = true;
    if (lifeCycleController.isActiveOTP) {
      PassengerAPIService.authApi
          .requestActiveAccountOTP(lifeCycleController.email);
    } else {
      PassengerAPIService.authApi
          .requestResetPassword(lifeCycleController.email);
    }
    isLoading2.value = false;
  }
}
