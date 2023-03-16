import 'package:customer_app/data/models/requests/create_passenger_request.dart';
import 'package:customer_app/data/models/requests/register_request.dart';
import 'package:customer_app/data/services/passenger_api_provider.dart';
import 'package:customer_app/modules/register/controllers/register_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/common/api_handler.dart';

class PasswordController extends GetxController {
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

    var body = RegisterRequestBody(
        email: registerController.emailController.text,
        phone: registerController.phoneNumberController.text,
        password: passwordController.text,
        role: "Passenger",
        name: registerController.nameController.text);

    var body2 = CreatePassengerRequestBody(
        Email: registerController.emailController.text,
        Phone: registerController.phoneNumberController.text,
        Name: registerController.nameController.text,
        Gender: false);

    try {
      print("Request Body ${body.toJson()}");
      await PassengerAPIService.register(body: body);
      print("Register Done");
      await PassengerAPIService.createPassenger(body: body2);
      print("Create Info Done");
      Get.offAllNamed(Routes.OTP);
      Get.snackbar(
          "Register successfully", "Enter your OTP to active this account",
          colorText: Colors.black, backgroundColor: Colors.grey[200]);
    } catch (e) {
      Get.snackbar("Failed: ", e.toString(),
          colorText: Colors.black, backgroundColor: Colors.grey[200]);
    }

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
