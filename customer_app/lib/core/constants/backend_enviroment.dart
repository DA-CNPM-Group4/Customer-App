class BackendEnviroment {
  static String host = "https://dacnpmbe11.azurewebsites.net/api";

  static checkDevelopmentMode() {
    assert(() {
      // host = "http://192.168.1.7:8001/api";

      // For Emulator
      host = "http://10.0.2.2:8001/api";
      return true;
    }());
  }

  /// For testing mode
  static void setTestHost(String testHost) {
    host = testHost;
  }
}
