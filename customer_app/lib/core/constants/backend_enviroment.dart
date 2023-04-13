import 'package:customer_app/core/constants/enum.dart';

class BackendEnviroment {
  static String host = "https://dacnpmbe11.azurewebsites.net/api";
  static ComunicationMode mode = ComunicationMode.ClientDoShit;

  static checkDevelopmentMode({bool isUseEmulator = false}) {
    assert(() {
      if (isUseEmulator) {
        host = "http://10.0.2.2:8001/api";
      } else {
        host = "http://192.168.1.7:8001/api";
      }
      return true;
    }());
  }

  static bool checkV2Comunication() {
    {
      return mode == ComunicationMode.BackDoShit;
    }
  }

  /// For testing mode
  static void setTestHost(String testHost) {
    host = testHost;
  }
}
