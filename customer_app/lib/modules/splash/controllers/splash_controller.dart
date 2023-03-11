import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  var isFirstTime = true;
  @override
  void onInit() async{
    super.onInit();
    var box = await Hive.openBox("box");
    print(await box.get("notFirstTime"));
    isFirstTime = await box.get("notFirstTime") ?? true;
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
