
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum SEARCHTYPES {
  LOCATION,
  MYDESTINATION,
  BOTH
}

void showSnackBar(String title, String message) {
    Get.snackbar(title, message, colorText: Colors.black, backgroundColor: Colors.grey[500]);
  }

 final formatBalance = NumberFormat("#,##0", "vi_VN");

