import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String title, String message) {
  Get.snackbar(title, message,
      colorText: Colors.black, backgroundColor: Colors.grey[500]);
}
