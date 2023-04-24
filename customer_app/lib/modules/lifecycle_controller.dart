import 'package:customer_app/Data/models/realtime_models/realtime_passenger.dart';
import 'package:customer_app/core/exceptions/bussiness_exception.dart';
import 'package:customer_app/modules/utils/widgets.dart';
import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/data/models/requests/create_passenger_request.dart';
import 'package:customer_app/data/services/rest/passenger_api_service.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LifeCycleController extends SuperController {
  late UserEntity? passenger;
  late RealtimePassenger? realtimePassenger;

  // born because of special problem from user page -> edit profile
  late final _rxPassenger = Rxn<UserEntity>();
  //////////////////////////////////////////////

  // variable use in save state, login, register, ....
  String phone = "";
  String email = "";
  String? googleEmail;
  String name = "";
  bool gender = false;
  bool isActiveOTP = true;
  bool isloginByGoogle = false;

  void setPreLoginState(
      {String? phone,
      String? email,
      String? name,
      bool? gender,
      bool? isActiveOTP,
      bool? isloginByGoogle,
      String? googleEmail}) {
    this.phone = phone ?? this.phone;
    this.email = email ?? this.email;
    this.name = name ?? this.name;
    this.gender = gender ?? this.gender;
    this.isActiveOTP = isActiveOTP ?? this.isActiveOTP;
    this.isloginByGoogle = isloginByGoogle ?? this.isloginByGoogle;
    this.googleEmail = googleEmail;
  }

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
          Email: email, Phone: phone, Name: name, Gender: gender);
      if (isloginByGoogle) {
        String? yourPhone = await openInputPhoneBottomSheet();
        if (yourPhone == null || googleEmail == null) {
          Future.error("You Must Enter Phone");
        }
        body2.Email = googleEmail!;
        body2.Phone = yourPhone!;
      }

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
    isloginByGoogle = false;
    isActiveOTP = true;
    phone = "";
    email = "";
    passenger = null;
    _rxPassenger.value = null;
    if (!isCallAPI) {
      Get.offAllNamed(Routes.WELCOME);
    }
  }
}
