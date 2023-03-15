import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHandler {
  static var host = "http://api.map4d.vn/sdk/";
  static final client = http.Client();

  static Future<Map<String, dynamic>> getWithQuery(
      String endpoint, Map<String, dynamic> query) async {
    http.Response response = await client.get(
      buildUrlWithQuery(endpoint, query),
      headers: {"Content-Type": "application/json"},
    );

    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> put(body, String endpoint) async {
    var response = await client.put(buildUrl(endpoint), body: jsonEncode(body));

    return json.decode(response.body);
  }

  static Uri buildUrl(String endpoint) {
    return Uri.parse(host + endpoint);
  }

  static Uri buildUrlWithQuery(String endpoint, Map<String, dynamic> query) {
    return Uri.parse(host + endpoint).replace(queryParameters: query);
  }
}
