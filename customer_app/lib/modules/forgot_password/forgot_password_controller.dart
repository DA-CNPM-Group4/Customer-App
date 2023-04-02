import 'package:customer_app/Data/models/requests/change_password_request.dart';
import 'package:customer_app/core/exceptions/bussiness_exception.dart';
import 'package:customer_app/core/utils/widgets.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/passenger_api_service.dart';
import '../lifecycle_controller.dart';

class ForgotPasswordController extends GetxController {
  final LifeCycleController lifeCycleController =
      Get.find<LifeCycleController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var emailError = ''.obs;

  TextEditingController emailController = TextEditingController();

  Future<void> sendResetPasswordOTP() async {
    isLoading.value = true;
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      isLoading.value = false;
    }

    try {
      await PassengerAPIService.authApi
          .requestResetPassword(emailController.text);

      toOTPPage();
    } catch (e) {
      showSnackBar("Error", e.toString());
    }

    isLoading.value = false;
  }

  void toOTPPage() {
    lifeCycleController.isActiveOTP = false;
    lifeCycleController.email = emailController.text;
    Get.toNamed(Routes.OTP);
  }

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    } else if (!value.isEmail) {
      return "You must enter a email address";
    }
    return null;
  }
}
