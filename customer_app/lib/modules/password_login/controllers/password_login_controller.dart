import 'package:customer_app/core/exceptions/bussiness_exception.dart';
import 'package:customer_app/data/common/util.dart';
import 'package:customer_app/data/models/requests/create_passenger_request.dart';
import 'package:customer_app/data/models/requests/login_request.dart';
import 'package:customer_app/data/services/passenger_api_provider.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../routes/app_pages.dart';

class PasswordLoginController extends GetxController {
  final LifeCycleController lifeCycleController =
      Get.find<LifeCycleController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;

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

  Future<void> login() async {
    isLoading.value = true;

    LoginRequestBody body = LoginRequestBody(
      email: lifeCycleController.email,
      phone: lifeCycleController.phone,
      password: passwordController.text,
    );

    try {
      await PassengerAPIService.authApi.login(body: body);
    } catch (e) {
      showSnackBar("Error", e.toString());
      isLoading.value = false;
      return;
    }


    try {
      await getPassengerInfoAndRoutingHome();
    } on IBussinessException catch (_) {
      await createPassengerInfo();
    } catch (e) {
      showSnackBar("Error", e.toString());
    }
    isLoading.value = false;
  }

  Future<void> createPassengerInfo() async {
    var body2 = CreatePassengerRequestBody(
        Email: lifeCycleController.email,
        Phone: lifeCycleController.phone,
        Name: lifeCycleController.name.isEmpty
            ? lifeCycleController.name
            : "Unknown",
        Gender: false);
    await PassengerAPIService.createPassenger(body: body2);

    await getPassengerInfoAndRoutingHome();
  }

  Future<void> getPassengerInfoAndRoutingHome() async {
    lifeCycleController.passenger =
        await PassengerAPIService.getPassengerInfo();
    Get.offNamedUntil(Routes.HOME, ModalRoute.withName(Routes.HOME));
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
