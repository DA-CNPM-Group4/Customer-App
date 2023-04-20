import 'package:customer_app/data/providers/graphql_provider.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLTripService {
  final GraphQLClient _client = MyGraphQLProvider.instance.client;

  Future<List<Map<String, dynamic>>> getTrips(String driverId) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLTripQueryString.queryTripRepositories),
      variables: <String, dynamic>{
        'driverId': driverId,
      },
    );
    final QueryResult result = await _client.query(options);
    if (result.hasException) {
      debugPrint(result.exception.toString());
    }

    return List<Map<String, dynamic>>.from(result.data!['tripByDriverId']);
  }
}

class GraphQLTripQueryString {
  static String queryTripRepositories = r'''
query TripByDriverId($driverId: String!) {
    tripByDriverId(driverId: $driverId) {
      price
      completeTime
      requestId
      tripStatus
      createdTime
    }
  }
''';
}
