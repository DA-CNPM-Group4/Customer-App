import 'package:customer_app/routes/app_pages.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (!Hive.isAdapterRegistered(0)) {
  //   Hive.registerAdapter(UserEntityAdapter());
  // }
  await Hive.initFlutter();
  box = await Hive.openBox("box");
  // await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: baseTheme(),
      builder: EasyLoading.init(),
      smartManagement: SmartManagement.keepFactory,
    ),
  );
}
