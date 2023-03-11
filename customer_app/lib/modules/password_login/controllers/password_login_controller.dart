import 'package:customer_app/data/common/util.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/common/api_handler.dart';
import '../../../routes/app_pages.dart';
import '../../login/controllers/login_controller.dart';

class PasswordLoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var loginController = Get.find<LoginController>();
  APIHandlerImp apiHandler = APIHandlerImp();
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
    var box = await Hive.openBox("box");
    await box.clear();
    print(passwordController.text);
    print({
      "username": '0${loginController.phoneNumberController.text}',
      "password": passwordController.text
    });
    var response = await apiHandler.post({
      "username": '0${loginController.phoneNumberController.text}',
      "password": passwordController.text
    }, "user/login");

    if (response.data["status"]) {
      await box.put("notFirstTime", false);
      Get.offNamedUntil(Routes.HOME, ModalRoute.withName(Routes.HOME));
      apiHandler.storeToken(response.data["data"]);
    } else {
      showSnackBar("Lỗi", "Mật khẩu không đúng");
    }
    isLoading.value = false;
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
