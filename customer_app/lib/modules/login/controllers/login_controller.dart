import 'package:customer_app/data/common/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  APIHandlerImp apiHandlerImp = APIHandlerImp();
  var emailError = ''.obs;
  var isLoading = false.obs;

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (!GetUtils.isEmail(value)) {
      return "This is not a valid phone number";
    }
    return null;
  }

  Future<bool> check() async {
    isLoading.value = true;
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      isLoading.value = false;
      return false;
    }

    var phoneResponse = await apiHandlerImp.post(
        {"phoneNumber": '0${phoneNumberController.text}'},
        "user/checkPhonenumber");

    if (!phoneResponse.data["status"]) {
      emailError.value = "Phone number is not existed, try another one";
      isLoading.value = false;
      return false;
    }
    formKey.currentState!.save();
    isLoading.value = false;
    return true;
  }

  @override
  void onInit() {
    super.onInit();
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
