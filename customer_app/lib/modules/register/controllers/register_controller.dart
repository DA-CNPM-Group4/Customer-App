import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailError = ''.obs;
  var phoneNumberError = ''.obs;
  var isLoading = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  String? nameValidator(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (RegExp(".*[0-9].*").hasMatch(value)) {
      return "Name can't have number";
    }
    return null;
  }

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (!GetUtils.isEmail(value)) {
      return "This is not an email";
    }
    return null;
  }

  String? phoneNumberValidator(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (!GetUtils.isPhoneNumber(value)) {
      return "This is a valid phone number";
    }
    return null;
  }

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

    formKey.currentState!.save();
    isLoading.value = false;
    return true;
  }

  getOTP() async {
    // var response = await apiHandlerImp.get("sendOTP", {
    //   "username": '0${phoneNumberController.text}'
    // });
    Get.toNamed(Routes.OTP);
  }
}
