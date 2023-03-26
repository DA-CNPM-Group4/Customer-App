import 'package:customer_app/modules/edit_profile/edit_profile_binding.dart';
import 'package:customer_app/modules/edit_profile/edit_profile_view.dart';
import 'package:customer_app/modules/find_transportation/bindings/find_transportation_binding.dart';
import 'package:customer_app/modules/find_transportation/views/find_transportation_view.dart';
import 'package:customer_app/modules/home/bindings/home_binding.dart';
import 'package:customer_app/modules/home/views/home_view.dart';
import 'package:customer_app/modules/map/bindings/map_binding.dart';
import 'package:customer_app/modules/map/views/map_view.dart';
import 'package:customer_app/modules/otp/bindings/otp_binding.dart';
import 'package:customer_app/modules/password_login/bindings/password_login_binding.dart';
import 'package:customer_app/modules/password_login/views/password_login_view.dart';
import 'package:customer_app/modules/search_page/bindings/search_page_binding.dart';
import 'package:customer_app/modules/search_page/views/search_page_view.dart';
import 'package:customer_app/modules/splash/bindings/splash_binding.dart';
import 'package:customer_app/modules/splash/views/splash_view.dart';
import 'package:customer_app/modules/user/bindings/user_binding.dart';
import 'package:customer_app/modules/user/views/user_view.dart';
import 'package:customer_app/modules/voucher/bindings/voucher_binding.dart';
import 'package:customer_app/modules/voucher/views/voucher_view.dart';
import 'package:get/get.dart';

import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/password/bindings/password_binding.dart';
import '../modules/password/views/password_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD,
      page: () => const PasswordView(),
      binding: PasswordBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD_LOGIN,
      page: () => const PasswordLoginView(),
      binding: PasswordLoginBinding(),
    ),
    GetPage(
        name: _Paths.SPLASH,
        page: () => const SplashView(),
        binding: SplashBinding(),
        bindings: [HomeBinding()]),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding(),
        bindings: [
          // FindTransportationBinding(),
          // SearchPageBinding()
        ]),
    GetPage(
        name: _Paths.FIND_TRANSPORTATION,
        page: () => const FindTransportationView(),
        binding: FindTransportationBinding(),
        bindings: [UserBinding()]),
    GetPage(
        name: _Paths.MAP,
        page: () => const MapView(),
        binding: MapBinding(),
        bindings: [UserBinding()]),
    GetPage(
      name: _Paths.SEARCH_PAGE,
      page: () => const SearchPageView(),
      binding: SearchPageBinding(),
    ),
    GetPage(
      name: _Paths.USER,
      page: () => const UserView(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.VOUCHER,
      page: () => const VoucherView(),
      binding: VoucherBinding(),
    ),
    GetPage(
        name: _Paths.OTP,
        page: () => const OtpView(),
        binding: OtpBinding(),
        bindings: [RegisterBinding()]),
  ];
}
