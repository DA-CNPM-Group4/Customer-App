import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final lifecycleController = Get.find<LifeCycleController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailError = ''.obs;
  var phoneNumberError = ''.obs;
  var isLoading = false.obs;

  RxBool gender = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Future<bool> check() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    isLoading.value = true;
    // check email exist
    emailError.value = '';
    // check phone exist
    phoneNumberError.value = '';

    lifecycleController.setPreLoginState(
      email: emailController.text,
      gender: gender.value,
      phone: phoneNumberController.text,
      name: nameController.text,
    );

    formKey.currentState!.save();
    isLoading.value = false;
    return true;
  }

  getOTP() async {
    Get.toNamed(Routes.OTP);
  }
}
