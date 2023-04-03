import 'package:customer_app/data/providers/api_provider.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LifeCycleController lifeCycleController = Get.find<LifeCycleController>();

  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  APIHandlerImp apiHandlerImp = APIHandlerImp();
  var emailError = ''.obs;
  var isLoading = false.obs;

  String? phoneNumberValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    } else if (!value.isPhoneNumber) {
      return "You must enter a right phone number";
    }
    return null;
  }

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    } else if (!value.isEmail) {
      return "You must enter a email address";
    }
    return null;
  }

  Future<void> validateAndSave() async {
    isLoading.value = true;
    final isPhoneValid = phoneFormKey.currentState!.validate();
    final isEmailValid = emailFormKey.currentState!.validate();
    if (!isPhoneValid || !isEmailValid) {
      isLoading.value = false;
      return;
    }
    // call api to check
    phoneFormKey.currentState!.save();
    emailFormKey.currentState!.save();
    isLoading.value = false;

    toPasswordLoginPage();
  }

  void toPasswordLoginPage() {
    lifeCycleController.email = emailController.text;
    lifeCycleController.phone = phoneNumberController.text;
    Get.toNamed(Routes.PASSWORD_LOGIN);
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
