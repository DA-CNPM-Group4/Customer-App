import 'package:customer_app/Data/models/realtime_models/realtime_passenger.dart';
import 'package:customer_app/core/utils/widgets.dart';
import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/data/services/passenger_api_service.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class LifeCycleController extends SuperController {
  late UserEntity? passenger;
  late RealtimePassenger? realtimePassenger;

  String phone = "";
  String email = "";
  String name = "";
  bool isActiveOTP = true;

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  void setAuthFieldInfo(String phone, String email) {
    this.phone = phone;
    this.email = email;
  }

  Future<void> logout() async {
    phone = "";
    email = "";
    name = "";
    passenger = null;
    realtimePassenger = null;
    try {
      await PassengerAPIService.authApi.logout();
    } catch (e) {
      showSnackBar("Error", e.toString());
    } finally {
      Get.offAllNamed(Routes.WELCOME);
    }
  }
}
