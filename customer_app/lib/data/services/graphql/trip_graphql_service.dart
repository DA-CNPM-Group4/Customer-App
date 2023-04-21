import 'package:customer_app/data/providers/graphql_provider.dart';
import 'package:customer_app/core/exceptions/unexpected_exception.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TripGraphQLService {
  GraphQLClient? _client;
  final String host;

  TripGraphQLService(this.host);

  Future<List<Map<String, dynamic>>> getTrips(String driverId) async {
    final QueryOptions options = QueryOptions(
      document: gql(TripGraphQLQueryString.queryTripRepositories),
      variables: <String, dynamic>{
        'driverId': driverId,
      },
    );
    final QueryResult result = await MyGraphQLProvider.baseQuery(
      host,
      client: _client,
      queryOptions: options,
    );

    if (result.hasException) {
      debugPrint(result.exception.toString());
      Future.error(const UnexpectedException(context: "graphql-get-trips"));
    }

    return List<Map<String, dynamic>>.from(result.data!['tripByDriverId']);
  }
}

class TripGraphQLQueryString {
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
  }
''';
}
