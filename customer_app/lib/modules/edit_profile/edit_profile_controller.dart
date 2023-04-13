import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/modules/utils/widgets.dart';
import 'package:customer_app/data/models/requests/update_passenger_request.dart';
import 'package:customer_app/data/services/rest/passenger_api_service.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class EditProfileController extends GetxController {
  final LifeCycleController lifeCycleController =
      Get.find<LifeCycleController>();
  late UserEntity passengerInfo;

  RxBool gender = true.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    passengerInfo = await lifeCycleController.getPassenger;
    gender.value = passengerInfo.gender;
    nameController.setText(passengerInfo.name);
    addressController.setText("Actually this field don't exist");
  }

  Future<void> validateAndSave() async {
    try {
      isLoading.value = true;
      final isValid = formKey.currentState!.validate();
      if (!isValid) {
        isLoading.value = false;
      }

      var body = UpdatePassengerRequestBody(
        Gender: gender.value,
        Name: nameController.text,
        Email: passengerInfo.email,
        Phone: passengerInfo.phone,
      );
      await PassengerAPIService.updatePassenger(body: body);
      showSnackBar("Edit Profile Success", "Your profile have been updated");

      lifeCycleController.setPassenger =
          await PassengerAPIService.getPassengerInfo();
    } catch (e) {
      showSnackBar("Error", e.toString());
    }
    isLoading.value = false;
  }
}
