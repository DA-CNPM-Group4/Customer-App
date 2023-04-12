class BackendEnviroment {
  static String host = "https://dacnpmbe11.azurewebsites.net/api";

  static checkDevelopmentMode() {
    assert(() {
      host = "http://192.168.1.7:8001/api";
      return true;
    }());
  }
}
