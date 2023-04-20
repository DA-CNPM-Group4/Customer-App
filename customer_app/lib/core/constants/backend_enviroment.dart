import 'package:customer_app/core/constants/enum.dart';

class BackendEnviroment {
  static String host = "https://dacnpmbe11.azurewebsites.net/api";
  static String graphqlHost = 'https://dacnpmbe11.azurewebsites/graphql';
  static ComunicationMode mode = ComunicationMode.ClientDoLogic;

  static checkDevelopmentMode({bool isUseEmulator = false}) {
    assert(() {
      if (isUseEmulator) {
        host = "http://10.0.2.2:8001/api";
        graphqlHost = "http://10.0.2.2:8001/graphql";
      } else {
        host = "http://192.168.1.8:8001/api";
        graphqlHost = "http://192.168.1.8:8001/graphql";
      }
      return true;
    }());
  }

  static bool checkV2Comunication() {
    {
      return mode == ComunicationMode.BackendDoLogic;
    }
  }

  /// For testing mode
  static void setTestHost(String testHost) {
    host = testHost;
  }
}
