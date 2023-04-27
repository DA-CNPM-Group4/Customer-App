import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/firebase_options.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';

void main() async {
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
      await _loginWithEmailAndPassword(
        tester,
        email: 'gyqyliro@afia.pro',
        phone: '123124001',
        password: '123456',
      );

      await _testClickOnBikeBooking(tester: tester);
      await _testClickOnSearchALocation(tester: tester);
      await _testSearchForADestination(tester: tester);
      await _testSetPickupLocationClickOnNext(tester: tester);
      await _testSetUpDestinationClickOnNext(tester: tester);
      await _testClickOnOrderTrip(tester: tester);
      await _testClickOnCancelOrder(tester: tester);
      await _testConfirmCancelOrder(tester: tester);
    });
  });
}

Future<void> _initApp(WidgetTester tester) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
  await tester.tap(find.byKey(const Key("welcome_login_btn")));
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('welcome_login_btn')), findsNothing);
  expect(find.byKey(const Key('login_email_field')), findsOneWidget);
}

Future<void> _loginWithEmailAndPassword(
    WidgetTester tester, {
      required String phone,
      required String email,
      required String password,
    }) async {
  await tester.tap(find.byKey(const Key('login_login_btn')));
  await tester.pumpAndSettle();
  expect(find.text("This field must be filled"), findsOneWidget);
  expect(find.text("This field is required"), findsOneWidget);

  await tester.enterText(find.byKey(const Key('login_email_field')), email);
  await tester.enterText(find.byKey(const Key("login_phone_field")), phone);
  await tester.tap(find.byKey(const Key('login_login_btn')));
  await tester.pumpAndSettle(const Duration(seconds: 1));

  await tester.tap(find.byKey(const Key('password_login_login_btn')));
  await tester.pumpAndSettle();
  expect(find.text("This field is required"), findsOneWidget);

  await tester.enterText(
      find.byKey(const Key("password_login_password_field")), password);
  await tester.tap(find.byKey(const Key('password_login_login_btn')));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  expect(find.byKey(const Key('password_login_login_btn')), findsNothing);
  await tester.pump(const Duration(seconds: 1));
  await tester.pump(const Duration(seconds: 1));
}


Future<void> _testClickOnBikeBooking({required WidgetTester tester}) async {
  expect(find.byKey(const Key('home_booking_bike')), findsOneWidget);
  await tester.tap(find.byKey(const Key("home_booking_bike")));
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.pump(const Duration(seconds: 1));
  await tester.pump(const Duration(seconds: 1));
  await tester.pump(const Duration(seconds: 1));
  expect(find.byKey(const Key("home_booking_bike")), findsNothing);
}

Future<void> _testClickOnSearchALocation({required WidgetTester tester}) async{
  await tester
      .tap(find.byKey(const Key("find_transportation_box_search_field")));
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.pump(const Duration(seconds: 1));
  await tester.pump(const Duration(seconds: 1));
  expect(find.byKey(const Key("find_transportation_box_search_field")), findsNothing);
}

Future<void> _testSearchForADestination({required WidgetTester tester}) async{
  await tester.enterText(
      find.byKey(const Key("search_page_view_search_for_a_destination")),
      "Khoa hoc xa hoi nhan van");
  await tester.pumpAndSettle(const Duration(seconds: 3));
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key("search_page_view_destination_item0")));
  await tester.pumpAndSettle(const Duration(seconds: 3));
  await tester.pump(const Duration(seconds: 1));
  await tester.pump(const Duration(seconds: 1));
  expect(find.byKey(const Key("search_page_view_destination_item0")), findsNothing);
}

Future<void> _testSetPickupLocationClickOnNext({required WidgetTester tester}) async{
  expect(find.text("Set pickup location"), findsOneWidget);
  await tester.tap(find.byKey(const Key("map_view_next_btn")));
  await tester.pumpAndSettle(const Duration(seconds: 3));
  await tester.pump(const Duration(seconds: 1));
  await tester.pump(const Duration(seconds: 1));
  expect(find.text("Set pickup location"), findsNothing);
}

Future<void> _testSetUpDestinationClickOnNext({required WidgetTester tester}) async{
  expect(find.text("Set up destination"), findsOneWidget);
  await tester.tap(find.byKey(const Key("map_view_next_btn")));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.pump(const Duration(seconds: 2));
  await tester.pump(const Duration(seconds: 2));
  await tester.pump(const Duration(seconds: 2));
  expect(find.text("Set up destination"), findsNothing);
}

Future<void> _testClickOnOrderTrip({required WidgetTester tester}) async{
  expect(find.byKey(const Key("map_view_order_btn")), findsOneWidget);
  await tester.tap(find.byKey(const Key("map_view_order_btn")));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.pump(const Duration(seconds: 2));
  await tester.pump(const Duration(seconds: 2));
  expect(find.byKey(const Key("map_view_order_btn")), findsNothing);
}

Future<void> _testClickOnCancelOrder({required WidgetTester tester}) async{
  expect(find.byKey(const Key("map_view_cancel_order_btn")), findsOneWidget);
  await tester.tap(find.byKey(const Key("map_view_cancel_order_btn")));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.pump(const Duration(seconds: 1));
  await tester.pump(const Duration(seconds: 1));
  await tester.pump(const Duration(seconds: 1));
  await tester.pump(const Duration(seconds: 1));

  expect(find.text('Yes'), findsOneWidget);
  expect(find.text('No'), findsOneWidget);
}

Future<void> _testConfirmCancelOrder({required WidgetTester tester}) async{
  expect(find.text('Yes'), findsOneWidget);
  expect(find.text('No'), findsOneWidget);
  await tester.tap(find.text('Yes'));
  await tester.pumpAndSettle(const Duration(seconds: 3));
  expect(find.text('Yes'), findsNothing);
  expect(find.text('No'), findsNothing);
  expect(find.byKey(const Key("map_view_order_btn")), findsOneWidget);
}


