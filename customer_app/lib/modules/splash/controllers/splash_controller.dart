import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashController extends GetxController {
  var isFirstTime = true;
  @override
  void onInit() async {
    super.onInit();
    var box = await Hive.openBox("box");
    isFirstTime = await box.get("notFirstTime") ?? true;
  }
}
