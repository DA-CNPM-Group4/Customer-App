import 'package:customer_app/data/providers/graphql_provider.dart';
import 'package:customer_app/core/exceptions/unexpected_exception.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InfoGraphQLService {
  GraphQLClient? _client;
  final String host;

  InfoGraphQLService(this.host);

  Future<Map<String, dynamic>> getDriverInfo(String driverId) async {
    final QueryOptions options = QueryOptions(
      document: gql(InfoGraphQLQueryString.queryDriverInfo(driverId)),
    );
    final QueryResult result = await MyGraphQLProvider.baseQuery(host,
        client: _client, queryOptions: options);
    if (result.hasException) {
      debugPrint(result.exception.toString());
      Future.error(const UnexpectedException(context: "graphql-get-Info"));
    }

    return Map<String, dynamic>.from(result.data!['driverById']);
  }
}

class InfoGraphQLQueryString {
  static String queryDriverInfo(String driverId) => '''
query{
   driverById(driverId: "$driverId"){
       gender
       name
       phone
   }
}
''';
}
