import 'package:customer_app/Data/models/realtime_models/realtime_passenger.dart';
import 'package:customer_app/core/exceptions/bussiness_exception.dart';
import 'package:customer_app/modules/utils/widgets.dart';
import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/data/models/requests/create_passenger_request.dart';
import 'package:customer_app/data/services/passenger_api_service.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LifeCycleController extends SuperController {
  late UserEntity? passenger;
  late RealtimePassenger? realtimePassenger;

  // born because of special problem from user page -> edit profile
  late final _rxPassenger = Rxn<UserEntity>();
  //////////////////////////////////////////////

  String phone = "";
  String email = "";
  String name = "";
  bool isActiveOTP = true;
  bool isloginByGoogle = false;

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  Future<void> getPassengerInfoAndRoutingHome() async {
    try {
      setPassenger = await PassengerAPIService.getPassengerInfo();
      Get.offAllNamed(Routes.HOME);
    } on IBussinessException catch (_) {
      var body2 = CreatePassengerRequestBody(
          Email: email,
          Phone: phone,
          Name: name.isEmpty ? name : "Unknown",
          Gender: false);
      await PassengerAPIService.createPassenger(body: body2);
      await getPassengerInfoAndRoutingHome();
    } catch (e) {
      showSnackBar("Error", e.toString());
      await logout();
    }
  }

  Future<void> logout() async {
    EasyLoading.show(status: 'Logout...');
    _resetState(isCallAPI: true);
    try {
      await PassengerAPIService.authApi.logout();
    } catch (e) {
      showSnackBar("Error", e.toString());
    } finally {
      EasyLoading.dismiss();
      Get.offAllNamed(Routes.WELCOME);
    }
  }

  Future<UserEntity> get getPassenger async {
    try {
      passenger ??= await PassengerAPIService.getPassengerInfo();
      return passenger!;
    } catch (e) {
      showSnackBar("Error", e.toString());
      await logout();
    }
    // never happen
    return passenger!;
  }

  Future<Rxn<UserEntity>> get getRxPassenger async {
    try {
      _rxPassenger.value ??= await getPassenger;
      return _rxPassenger;
    } catch (e) {
      showSnackBar("Error", e.toString());
      await logout();
    }
    return _rxPassenger;
  }

  set setPassenger(UserEntity passengerEntity) {
    passenger = passengerEntity;
    _rxPassenger.value = passenger;
  }

  void _resetState({bool isCallAPI = false}) {
    phone = "";
    email = "";
    passenger = null;
    _rxPassenger.value = null;
    if (!isCallAPI) {
      Get.offAllNamed(Routes.WELCOME);
    }
  }
}
