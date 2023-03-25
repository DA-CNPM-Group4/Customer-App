import 'package:customer_app/Data/models/realtime_models/realtime_passenger.dart';
import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:get/get.dart';

class LifeCycleController extends SuperController {
  late UserEntity driver;
  late RealtimePassenger realtimeDriver;

  String phone = "";
  String email = "";

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
}
