import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  RxBool defaultGender = true.obs;

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

  String? phoneNumberValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    }
    return value.isPhoneNumber ? null : "You must enter a right phone number";
  }

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    }
    return value.isEmail ? null : "You must enter a right email";
  }

  String? idValidator(String value) {
    if (value.isEmpty) {
      return "This field must be filled";
    }
    return value.length >= 12 ? null : "ID length can't be lower than 12";
  }

  String? driverLicenseValidator(String value) {
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

  var selectedIndex = 0.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // Future<bool> validateAndSave() async {
  //   isLoading.value = true;
  //   final isValid = formKey.currentState!.validate();
  //   if (!isValid) {
  //     isLoading.value = false;
  //     return false;
  //   }

  //   // var response = await apiHandlerImp.post({
  //   //   "phoneNumber": phoneNumberController.text,
  //   //   "email": emailController.text,
  //   //   "driverName": nameController.text,
  //   //   "gender": defaultGender.value ? "Male" : "Female",
  //   //   "driverAddress": addressController.text,
  //   //   "citizenId": idController.text,
  //   //   "driverLicenseId": driverLicenseController.text
  //   // }, "driver/checkDriverInfo");

  //   // if (!response.data["status"]) {
  //   //   print(response.data["data"]);
  //   //   isLoading.value = false;
  //   //   return false;
  //   // }

  //   var body = CreateDriverRequestBody(
  //     Address: addressController.text,
  //     AverageRate: 0,
  //     NumberOfRate: 0,
  //     NumberOfTrip: 0,
  //     Email: registerController.emailController.text,
  //     Gender: defaultGender.value,
  //     IdentityNumber: idController.text,
  //     Name: nameController.text,
  //     Phone: registerController.phoneNumberController.text,
  //   );

  //   try {
  //     await DriverAPIService.createDriver(body: body);
  //     isLoading.value = false;
  //     Get.toNamed(Routes.VEHICLE_REGISTRATION);
  //   } catch (e) {
  //     showSnackBar("Oh no", e.toString());
  //   }

  //   isLoading.value = false;
  //   return false;
  // }

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
