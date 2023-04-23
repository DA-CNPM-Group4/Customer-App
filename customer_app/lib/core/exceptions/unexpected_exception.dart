import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UnexpectedException implements Exception {
  const UnexpectedException(
      {this.debugMessage = "Unexprected exception",
      this.context = "unknown",
      this.message});

  final String? message;
  final String? debugMessage;
  final String? context;

  @override
  String toString() {
    String result = message ?? "Something went wrong! Contact the owner";
    if (debugMessage is String) {
      debugPrint('$context: $debugMessage');
    }
    return result;
  }

  static Future<void> handleFatalException(Object e) async {
    if (e is RefreshTokenException) {
      await Get.find<LifeCycleController>().logout();
    }
  }
}

class RefreshTokenException extends UnexpectedException {
  const RefreshTokenException(
      {String? message = "Something went wrong! Try Login again",
      String? debugMessage = "Failed to refresh token! Force Logout",
      String? context})
      : super(message: message, debugMessage: debugMessage, context: context);
}
