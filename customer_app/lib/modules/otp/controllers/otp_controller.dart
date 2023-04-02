import 'dart:async';

import 'package:customer_app/core/exceptions/bussiness_exception.dart';
import 'package:customer_app/data/common/util.dart';
import 'package:customer_app/data/models/requests/create_passenger_request.dart';
import 'package:customer_app/data/providers/api_provider.dart';
import 'package:customer_app/data/services/passenger_api_service.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/modules/register/controllers/register_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  //TODO: Implement OtpController
  final lifeCycleController = Get.find<LifeCycleController>();

  var isLoading = false.obs;
  var isLoading2 = false.obs;
  var isClicked = true.obs;
  TextEditingController otpController = TextEditingController();

  Timer? timer;
  APIHandlerImp apiHandlerImp = APIHandlerImp();
  var start = 15.obs;
  var registerController = Get.find<RegisterController>();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var error = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await startTimer();
  }

  String? validator() {
    if (otpController.text.isEmpty) {
      return "OTP can't be empty";
    } else if (otpController.text.length < 6) {
      return "Please fill all the numbers";
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (value.length < 6) {
      return "Password length must be longer than 6 digits";
    }
    return null;
  }

  Future<bool> validateOTP() async {
    return true;
  }

  Future<void> confirmOTP() async {
    isLoading.value = true;
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();

    try {
      if (lifeCycleController.isActiveOTP) {
        await PassengerAPIService.authApi
            .activeAccountByOTP(lifeCycleController.email, otpController.text);
        try {
          await getPassengerInfoAndRoutingHome();
        } on IBussinessException catch (_) {
          await createPassengerInfo();
        } catch (e) {
          showSnackBar("Error", e.toString());
        }
      } else {
        await PassengerAPIService.authApi.resetPassword(
            lifeCycleController.email,
            passwordController.text,
            otpController.text);
        Get.offNamedUntil(Routes.WELCOME, ModalRoute.withName(Routes.WELCOME));
        showSnackBar("Reset Password", "Reset Password Successfully!");
      }
    } catch (e) {
      showSnackBar("Error", e.toString());
    }
    isLoading.value = false;
    return;
  }

  Future<void> createPassengerInfo() async {
    var body2 = CreatePassengerRequestBody(
        Email: lifeCycleController.email,
        Phone: lifeCycleController.phone,
        Name: lifeCycleController.name.isEmpty
            ? lifeCycleController.name
            : "Unknown",
        Gender: false);
    await PassengerAPIService.createPassenger(body: body2);

    await getPassengerInfoAndRoutingHome();
  }

  Future<void> getPassengerInfoAndRoutingHome() async {
    lifeCycleController.passenger =
        await PassengerAPIService.getPassengerInfo();
    Get.offNamedUntil(Routes.HOME, ModalRoute.withName(Routes.HOME));
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
