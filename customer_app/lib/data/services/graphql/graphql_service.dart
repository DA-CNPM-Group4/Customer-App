import 'package:customer_app/data/services/graphql/info_graphql_service.dart';
import 'package:customer_app/data/services/graphql/trip_graphql_service.dart';
import 'package:customer_app/core/constants/backend_enviroment.dart';

class GraphQLService {
  static final InfoGraphQLService infoGraphQLService =
      InfoGraphQLService(BackendEnviroment.graphQLEnviroment.infoHost);
  static final TripGraphQLService tripGraphQLService =
      TripGraphQLService(BackendEnviroment.graphQLEnviroment.tripHost);
}
