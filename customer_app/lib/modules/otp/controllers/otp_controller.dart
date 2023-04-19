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
    final isOTPValid = otpFormKey.currentState!.validate();
    if (!lifeCycleController.isActiveOTP) {
      if (!passwordFormKey.currentState!.validate()) {
        return;
      }
    }
    if (!isOTPValid) {
      return;
    }
    otpFormKey.currentState?.save();
    passwordFormKey.currentState?.save();

    try {
      isLoading.value = true;
      if (lifeCycleController.isActiveOTP) {
        await handleActiveAccount();
      } else {
        await handleResetPassword();
      }
    } on IBussinessException catch (e) {
      showSnackBar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
    return;
  }

  Future<void> handleActiveAccount() async {
    try {
      await PassengerAPIService.authApi
          .activeAccountByOTP(lifeCycleController.email, otpController.text);
    } catch (e) {
      showSnackBar("Active Account Failed", e.toString());
    }

    await lifeCycleController.getPassengerInfoAndRoutingHome();
  }

  Future<void> handleResetPassword() async {
    try {
      await PassengerAPIService.authApi.resetPassword(lifeCycleController.email,
          passwordController.text, otpController.text);
      Get.offAllNamed(Routes.WELCOME);
      showSnackBar("Reset Password", "Reset Password Successfully!");
    } catch (e) {
      showSnackBar("Reset Password Failed", e.toString());
    }
  }

  Future<void> startTimer() async {
    await handleSendOTP();
  }

  Future<void> handleSendOTP() async {
    try {
      isLoading2.value = true;
      if (lifeCycleController.isActiveOTP) {
        PassengerAPIService.authApi
            .requestActiveAccountOTP(lifeCycleController.email);
      } else {
        PassengerAPIService.authApi
            .requestResetPassword(lifeCycleController.email);
      }
      showSnackBar(
          "Success",
          lifeCycleController.isActiveOTP
              ? "Check your email to active account"
              : "check your email to get reset password code");
    } catch (e) {
      showSnackBar("Failed", e.toString());
    } finally {
      isLoading2.value = false;
    }
  }
}
