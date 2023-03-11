import 'package:customer_app/modules/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/common/api_handler.dart';

class PasswordController extends GetxController {
  //TODO: Implement PasswordController
  var registerController = Get.find<RegisterController>();
  var isLoading = false.obs;
  APIHandlerImp apiHandlerImp = APIHandlerImp();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (value.length < 6) {
      return "Password length must be longer than 6 digits";
    }
    return null;
  }

  bool check() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    formKey.currentState!.save();
    return true;
  }

  register() async {
    isLoading.value = true;
    var response = await apiHandlerImp.post({
      "username": '0${registerController.phoneNumberController.text}',
      "password": passwordController.text,
      "userInfor": {
        "email": registerController.emailController.text,
        "fullName": registerController.nameController.text
      }
    }, "user/signup");
    print({
      "username": '0${registerController.phoneNumberController.text}',
      "password": passwordController.text,
      "userInfor": {
        "email": registerController.emailController.text,
        "fullName": registerController.nameController.text
      }
    });
    isLoading.value = false;
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
