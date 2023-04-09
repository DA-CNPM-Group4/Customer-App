import 'package:customer_app/Data/models/requests/change_password_request.dart';
import 'package:customer_app/modules/utils/widgets.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/passenger_api_service.dart';
import '../lifecycle_controller.dart';

class ChangePasswordController extends GetxController {
  final LifeCycleController lifeCycleController =
      Get.find<LifeCycleController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Future<void> validateAndSave() async {
    isLoading.value = true;
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      isLoading.value = false;
    }

    ChangePasswordRequest body = ChangePasswordRequest(
      currentPassword: oldPasswordController.text,
      newPassword: newPasswordController.text,
    );

    try {
      await PassengerAPIService.authApi.changePassword(body);
      showSnackBar("Success", "Change Password Success");
    } catch (e) {
      showSnackBar("Error", e.toString());
    }

    isLoading.value = false;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    } else if (value.length < 6) {
      return "The password length must be greater than 6 digits";
    }
    return null;
  }
}
