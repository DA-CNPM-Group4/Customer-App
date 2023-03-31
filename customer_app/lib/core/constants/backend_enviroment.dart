class BackendEnviroment {
  static String host = "https://dacnpmbe11.azurewebsites.net/api";

  static checkDevelopmentMode() {
    assert(() {
      host = "http://10.124.3.85:8001/api";
      return true;
    }());
  }
}
