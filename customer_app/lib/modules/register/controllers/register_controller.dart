import 'package:customer_app/data/common/api_handler.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailError = ''.obs;
  var phoneNumberError = ''.obs;
  var isLoading = false.obs;
  APIHandlerImp apiHandlerImp = APIHandlerImp();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await apiHandlerImp.deleteToken();
  }

  String? nameValidator(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (RegExp(".*[0-9].*").hasMatch(value)) {
      return "Name can't have number";
    }
    return null;
  }

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if(!GetUtils.isEmail(value)) {
      return "This is not an email";
    }
    return null;
  }

  String? phoneNumberValidator(String value){
    if (value.isEmpty) {
      return "This field is required";
    } else if(!GetUtils.isPhoneNumber(value)) {
      return "This is a valid phone number";
    }
    return null;
  }

  Future<bool> check() async{
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    isLoading.value = true;

    print(emailController.text);
    var emailResponse = await apiHandlerImp.post({
      "email": emailController.text
    },
        "user/checkEmail");

    if(emailResponse.data["status"]){
      emailError.value = "Email is existed, try another one";
      isLoading.value = false;
      return false;
    }
    emailError.value = '';


    print(phoneNumberController.text);
    var phoneResponse = await apiHandlerImp.post({
      "phoneNumber": '0${phoneNumberController.text}'
    },
        "user/checkPhonenumber");

    if(phoneResponse.data["status"]){
      phoneNumberError.value = "Phone number is existed, try another one";
      isLoading.value = false;
      return false;
    }

    formKey.currentState!.save();
    isLoading.value = false;
    phoneNumberError.value = '';
    return true;
  }
  
  getOTP() async{
    // var response = await apiHandlerImp.get("sendOTP", {
    //   "username": '0${phoneNumberController.text}'
    // });
    Get.toNamed(Routes.OTP);
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
