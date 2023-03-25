import 'package:customer_app/Data/models/requests/change_password_request.dart';
import 'package:customer_app/Data/models/requests/login_response.dart';
import 'package:customer_app/core/exceptions/bussiness_exception.dart';
import 'package:customer_app/core/exceptions/unexpected_exception.dart';
import 'package:customer_app/data/models/requests/login_request.dart';
import 'package:customer_app/data/models/requests/register_request.dart';
import 'package:customer_app/data/providers/api_provider.dart';

class GeneralAPIService {
  Future<void> login({required LoginRequestBody body}) async {
    try {
      var response = await APIHandlerImp.instance
          .post(body.toJson(), '/Authentication/Login');

      if (response.data["status"]) {
        var body = LoginResponseBody.fromJson(response.data['data']);
        print("Login Result: " + body.toJson().toString());
        await _storeAllIdentity(body);
      } else {
        return Future.error(IBussinessException(response.data['message']));
      }
    } catch (e) {
      return Future.error(
          UnexpectedException(context: "login", debugMessage: e.toString()));
    }
  }

  Future<void> register(RegisterRequestBody body) async {
    try {
      var response = await APIHandlerImp.instance
          .post(body.toJson(), '/Authentication/Register');
      if (response.data["status"]) {
      } else {
        return Future.error(IBussinessException(response.data['message']));
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "register-account", debugMessage: e.toString()));
    }
  }

  Future<void> changePassword(ChangePasswordRequest body) async {
    try {
      var response = await APIHandlerImp.instance.post(
        body.toJson(),
        "/Authentication/ChangePassword",
        useToken: true,
      );
      if (response.data['status']) {
      } else {
        return Future.error(IBussinessException(response.data['message']));
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "change-password", debugMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      var response = await APIHandlerImp.instance.post(
        null,
        "/Authentication/Logout",
        useToken: true,
      );
      if (response.data['status']) {
      } else {
        return Future.error(IBussinessException(response.data['message']));
      }
    } catch (e) {
      return Future.error(
          UnexpectedException(context: "logout", debugMessage: e.toString()));
    } finally {
      await APIHandlerImp.instance.deleteToken();
    }
  }
}

Future<void> _storeAllIdentity(LoginResponseBody body) async {
  await APIHandlerImp.instance.storeIdentity(body.accountId);
  await APIHandlerImp.instance.storeRefreshToken(body.refreshToken);
  await APIHandlerImp.instance.storeAccessToken(body.accessToken);
}
