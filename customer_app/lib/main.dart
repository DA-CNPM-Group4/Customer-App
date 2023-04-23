import 'package:customer_app/core/constants/backend_enviroment.dart';
import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/firebase_options.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // BackendEnviroment.checkDevelopmentMode();
  await setup();
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

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(UserEntityAdapter());
  }
  await Hive.initFlutter();
  await Hive.openBox("box");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(LifeCycleController(), permanent: true);
}
