import 'package:customer_app/core/exceptions/bussiness_exception.dart';
import 'package:customer_app/data/providers/api_provider.dart';
import 'package:customer_app/data/services/rest/passenger_api_service.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/modules/utils/widgets.dart';
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
  var errorText = ''.obs;

  var isLoading = false.obs;

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
    // lifeCycleController.isloginByGoogle = false;
    // lifeCycleController.email = emailController.text;
    // lifeCycleController.phone = phoneNumberController.text;

    lifeCycleController.setPreLoginState(
        isloginByGoogle: false,
        email: emailController.text,
        phone: phoneNumberController.text);

    Get.toNamed(Routes.PASSWORD_LOGIN);
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;

    String gooleEmail = await PassengerAPIService.authApi.loginByGoogle();
    try {
      lifeCycleController.setPreLoginState(
        isloginByGoogle: true,
        googleEmail: gooleEmail,
      );
    } on CancelActionException catch (_) {
      isLoading.value = false;
      return;
    } catch (e) {
      showSnackBar("Sign in", e.toString());
      isLoading.value = false;
      return;
    }
    await lifeCycleController.getPassengerInfoAndRoutingHome();
    isLoading.value = false;
  }
}
