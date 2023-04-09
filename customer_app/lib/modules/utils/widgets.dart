import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String title, String message, {int second = 3}) {
  Get.snackbar(title, message,
      isDismissible: true,
      colorText: Colors.black,
      backgroundColor: const Color.fromARGB(255, 130, 230, 63),
      duration: Duration(seconds: second));
}
