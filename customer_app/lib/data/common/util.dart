import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum SEARCHTYPES { location, mydestination, both }

void showSnackBar(String title, String message, {int second = 3}) {
  Get.snackbar(title, message,
      isDismissible: true,
      colorText: Colors.black,
      backgroundColor: const Color.fromARGB(255, 130, 230, 63),
      duration: Duration(seconds: second));
}

final formatBalance = NumberFormat("#,##0", "vi_VN");
