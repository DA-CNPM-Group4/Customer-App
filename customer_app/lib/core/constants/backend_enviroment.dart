import 'package:customer_app/core/constants/enum.dart';

class BackendEnviroment {
  static ComunicationMode mode = ComunicationMode.BackendDoLogic;
  static bool isPoor = false;
  static String url = "https://dacnpm4be.azurewebsites.net";

  static String get host => "$url/api";
  static GraphQLEnviroment graphQLEnviroment = GraphQLEnviroment(url);

  static checkDevelopmentMode({bool isUseEmulator = false}) {
    assert(() {
      if (isUseEmulator) {
        url = "http://10.0.2.2:8001";
        graphQLEnviroment.graphqlHost = url;
      } else {
        url = "http://192.168.1.4:8001";
        graphQLEnviroment.graphqlHost = url;
      }
      return true;
    }());
  }

  static bool checkV2Comunication() {
    {
      return mode == ComunicationMode.BackendDoLogic;
    }
  }
}

class GraphQLEnviroment {
  String graphqlHost = 'https://dacnpmbe.azurewebsites.net';

  String tripPath = '/trip/graphql';
  String infoPath = '/info/graphql';

  String get tripHost => graphqlHost + tripPath;
  String get infoHost => graphqlHost + infoPath;

  GraphQLEnviroment(this.graphqlHost);
}
