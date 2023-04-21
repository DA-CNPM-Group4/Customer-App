import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:customer_app/core/constants/backend_enviroment.dart';
import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  BackendEnviroment.checkDevelopmentMode(isUseEmulator: true);

  WidgetsFlutterBinding.ensureInitialized();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(UserEntityAdapter());
  }
  await Hive.initFlutter();
  await Hive.openBox("box");

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Request a trip |', () {
    testWidgets("Login flow |", (WidgetTester tester) async {
      // Initialize the app
      await _initApp(tester);

      // Navigate to the login screen
      await _navigateFromWelcomeToLogin(tester);

      // Log in with email and password
      await _loginWithEmailAndPassword(tester);
    });
  });
}

Future<void> _initApp(WidgetTester tester) async {
  await tester.pumpWidget(
    GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: baseTheme(),
      builder: EasyLoading.init(),
      smartManagement: SmartManagement.keepFactory,
      onInit: () {
        Get.put(LifeCycleController(), permanent: true);
      },
    ),
  );
}

Future<void> _navigateFromWelcomeToLogin(WidgetTester tester) async {
  final loginFinder = find.byKey(const Key("welcome_login_btn"));
  await tester.tap(loginFinder);
  // await Future.delayed(const Duration(seconds: 3)); // Wait for 3 seconds
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('login_email_field')), findsOneWidget);
}

Future<void> _loginWithEmailAndPassword(WidgetTester tester) async {
  final emailFinder = find.byKey(const Key('login_email_field'));
  final phoneFinder = find.byKey(const Key("login_phone_field"));
  await tester.enterText(emailFinder, 'changkho6310@gmail.com');
  await tester.enterText(phoneFinder, '123456222');
  await tester.tap(find.byKey(const Key('login_login_btn')));
  await tester.pumpAndSettle();
  // await Future.delayed(const Duration(seconds: 1));

  final passwordFinder = find.byKey(const Key("password_login_password_field"));
  await tester.enterText(passwordFinder, '123456');
  await tester.tap(find.byKey(const Key('password_login_login_btn')));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 2));

  expect(find.byKey(const Key('home_booking_bike')), findsOneWidget);
  // final bookingBikeFinder = find.byKey(const Key("home_booking_bike"));
  // await tester.tap(bookingBikeFinder);
  // await tester.pumpAndSettle();
  // await Future.delayed(const Duration(seconds: 2));
  //
  // final searchBoxFinder = find.byKey(const Key("find_transportation_box_search_field"));
  // await tester.tap(searchBoxFinder);
  // await tester.pumpAndSettle();
  // await Future.delayed(const Duration(seconds: 2));
}
