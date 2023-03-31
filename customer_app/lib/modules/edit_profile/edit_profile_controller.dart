import 'package:customer_app/core/utils/widgets.dart';
import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/data/models/requests/update_passenger_request.dart';
import 'package:customer_app/data/services/passenger_api_service.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class EditProfileController extends GetxController {
  final LifeCycleController lifeCycleController =
      Get.find<LifeCycleController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  RxBool gender = true.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? nameValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    }
    return RegExp(r'^[a-z A-Z,.\-]+$',
                caseSensitive: false, unicode: true, dotAll: true)
            .hasMatch(value)
        ? null
        : "Name can't contains special characters or number";
  }

  String? idValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    }
    return value.length >= 12 ? null : "ID length can't be lower than 12";
  }

  String? addressValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    }
    return null;
  }

  Future<void> validateAndSave() async {
    try {
      isLoading.value = true;
      final isValid = formKey.currentState!.validate();
      if (!isValid) {
        isLoading.value = false;
      }

      var body = UpdatePassengerRequestBody(
        Gender: lifeCycleController.passenger!.gender,
        Name: nameController.text,
        Email: lifeCycleController.passenger!.email,
        Phone: lifeCycleController.passenger!.phone,
      );
      await PassengerAPIService.updatePassenger(body: body);
      showSnackBar("Edit Profile Success", "Your profile have been updated");

      lifeCycleController.passenger =
          await PassengerAPIService.getPassengerInfo();
    } catch (e) {
      showSnackBar("Error", e.toString());
    }
    isLoading.value = false;
  }

  @override
  void onInit() async {
    try {
      lifeCycleController.passenger ??=
          await PassengerAPIService.getPassengerInfo();

      gender.value = lifeCycleController.passenger!.gender;
      nameController.setText(lifeCycleController.passenger!.name);
      addressController.setText("Actually this field don't exist");
    } catch (e) {
      showSnackBar("Error", e.toString());
      Get.offAllNamed(Routes.WELCOME);
    }
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }
}
