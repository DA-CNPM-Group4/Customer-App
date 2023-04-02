class BackendEnviroment {
  static String host = "https://dacnpmbe11.azurewebsites.net/api";

  static checkDevelopmentMode() {
    assert(() {
      host = "http://192.168.50.251/api";
      return true;
    }());
  }
}
