import 'package:customer_app/core/constants/backend_enviroment.dart';
import 'package:customer_app/data/models/requests/register_request.dart';
import 'package:customer_app/data/models/requests/register_request_2.dart';
import 'package:customer_app/data/providers/api_provider.dart';
import 'package:customer_app/data/services/rest/passenger_api_service.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/modules/register/controllers/register_controller.dart';
import 'package:customer_app/modules/utils/widgets.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordController extends GetxController {
  final LifeCycleController lifeCycleController =
      Get.find<LifeCycleController>();

  var registerController = Get.find<RegisterController>();
  var isLoading = false.obs;
  APIHandlerImp apiHandlerImp = APIHandlerImp();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

    try {
      await handleRegister();
      Get.offAllNamed(Routes.WELCOME);
      showSnackBar("Sucess", "Register successfully");
    } catch (e) {
      showSnackBar("Failed", e.toString());
    }

    isLoading.value = false;
  }

  Future<void> handleRegister() async {
    if (BackendEnviroment.checkV2Comunication()) {
      final requestBodyV2 = RegisterRequestBodyV2(
          gender: registerController.gender.value,
          email: registerController.emailController.text,
          phone: registerController.phoneNumberController.text,
          password: passwordController.text,
          role: "Passenger",
          name: registerController.nameController.text);

      await PassengerAPIService.authApi.registerV2(requestBodyV2);
    } else {
      final requestBodyV1 = RegisterRequestBody(
          email: registerController.emailController.text,
          phone: registerController.phoneNumberController.text,
          password: passwordController.text,
          role: "Passenger",
          name: registerController.nameController.text);
      await PassengerAPIService.authApi.register(requestBodyV1);
    }
  }
}
