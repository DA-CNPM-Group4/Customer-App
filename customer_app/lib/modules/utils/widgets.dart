import 'package:customer_app/core/utils/utils.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';

void showSnackBar(String title, String message, {int second = 3}) {
  Get.snackbar(title, message,
      isDismissible: true,
      colorText: Colors.black,
      backgroundColor: const Color.fromARGB(255, 130, 230, 63),
      duration: Duration(seconds: second));
}

final formatBalance = NumberFormat("#,##0", "vi_VN");

Future<String?> openInputPhoneBottomSheet() async {
  final GlobalKey<FormState> phoneFormKeyBottomSheet = GlobalKey<FormState>();
  String? errorText;
  TextEditingController phoneNumberBottomSheetController =
      TextEditingController();
  String? phone = await Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(20),
      height: Get.height * 0.2,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SizedBox(
        width: Get.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Form(
                key: phoneFormKeyBottomSheet,
                child: TextFormField(
                  controller: phoneNumberBottomSheetController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) =>
                      StringValidator.phoneNumberValidator(value!),
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      errorText: errorText,
                      hintText: 'Enter phone number',
                      hintStyle: BaseTextStyle.body3(color: Colors.grey),
                      suffixIcon: const Icon(Icons.phone_android)),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (await StringValidator.validateField(
                      phoneFormKeyBottomSheet)) {
                    Get.back(
                      result: phoneNumberBottomSheetController.text,
                    );
                  }
                },
                child: const Text("OK"))
          ],
        ),
      ),
    ),
  );
  return phone;
}
