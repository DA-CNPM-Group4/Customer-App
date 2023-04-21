import 'dart:io';

import 'package:customer_app/core/utils/secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyGraphQLProvider {
  static Future<GraphQLClient> _initlizeGraphQLClient(String uri) async {
    final httpLink = HttpLink(
      uri,
      defaultHeaders: await _defaultHeader(),
    );
    return GraphQLClient(
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
        query: Policies(
          fetch: FetchPolicy.networkOnly,
        ),
      ),
      link: httpLink,
    );
  }

  static Future<Map<String, String>> _defaultHeader() async {
    var baseHeader = {
      HttpHeaders.dateHeader: DateTime.now().millisecondsSinceEpoch.toString(),
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
    };
    baseHeader["X-Api-Key"] = "ApplicationKey";

    String? token = await SecureStorage.getAccessToken();
    if (token != "") {
      baseHeader["Authorization"] = "Bearer $token";
    }
    return baseHeader;
  }

  static Future<QueryResult> baseQuery(
    String uri, {
    required GraphQLClient? client,
    required QueryOptions queryOptions,
  }) async {
    client ??= await _initlizeGraphQLClient(uri);
    return await client.query(queryOptions);
  }

  // void _setToken(
  //   Link link, {
  //   bool useToken = false,
  //   bool useRefereshToken = false,
  // }) async {
  //   if (useToken) {
  //     String? token = !useRefereshToken
  //         ? await SecureStorage.getAccessToken()
  //         : await SecureStorage.getRefreshToken();
  //     if (token != "") {
  //       AuthLink alink = AuthLink(getToken: () async => 'Bearer $token');
  //       link.concat(alink);
  //     }
  //   }
  // }
}
