import 'package:customer_app/core/constants/backend_enviroment.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyGraphQLProvider {
  late final Link httpLink;
  late final GraphQLClient client;

  static final MyGraphQLProvider _singleton = MyGraphQLProvider._internal();
  static MyGraphQLProvider get instance => _singleton;

  factory MyGraphQLProvider() {
    return _singleton;
  }

  MyGraphQLProvider._internal() {
    httpLink = HttpLink(
      BackendEnviroment.graphqlHost,
    );

    client = GraphQLClient(
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
        query: Policies(
          fetch: FetchPolicy.networkOnly,
        ),
      ),
      link: httpLink,
    );
  }
}
