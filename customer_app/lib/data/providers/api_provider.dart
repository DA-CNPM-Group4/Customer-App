import 'dart:convert';
import 'dart:io';
import 'package:customer_app/core/constants/backend_enviroment.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class APIHandlerInterface {
  Future<Response> get(String endpoint, {Map<String, dynamic>? query});
  Future<Response> post(var body, String endpoint,
      {Map<String, dynamic>? query});
  Future<Response> put(var body, String endpoint,
      {Map<String, dynamic>? query});

  Future<void> storeRefreshToken(String token);
  Future<void> storeAccessToken(String token);
  Future<void> storeIdentity(String token);

  Future<String?> getRefreshToken();
  Future<String?> getAccessToken();
  Future<String?> getIdentity();

  Future<void> deleteToken();
}

class APIHandlerImp implements APIHandlerInterface {
  static String host = BackendEnviroment.host;
  static const _storage = FlutterSecureStorage();
  static final client = Dio();

  static final APIHandlerImp _singleton = APIHandlerImp._internal();
  static APIHandlerImp get instance => _singleton;

  factory APIHandlerImp() {
    return _singleton;
  }

  APIHandlerImp._internal(
      // init here
      );

  Future<Map<String, String>> _buildHeader({
    bool useToken = false,
    bool useRefereshToken = false,
  }) async {
    var baseHeader = {
      HttpHeaders.dateHeader: DateTime.now().millisecondsSinceEpoch.toString(),
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      "device": "app"
    };
    baseHeader["X-Api-Key"] = "ApplicationKey";

    if (useToken) {
      String? token =
          !useRefereshToken ? await getAccessToken() : await getRefreshToken();
      if (token != "") {
        baseHeader["Authorization"] = "Bearer $token";
      }
    }
    return baseHeader;
  }

  static Uri buildUrlWithQuery(String endpoint, Map<String, dynamic> query) {
    return query.isEmpty
        ? Uri.parse(host + endpoint).replace(queryParameters: query)
        : Uri.parse(host + endpoint);
  }

  @override
  Future<Response> post(
    var body,
    String endpoint, {
    bool useToken = false,
    Map<String, dynamic>? query,
  }) async {
    Response response = await client.post(host + endpoint,
        data: json.encode(body),
        queryParameters: query,
        options: Options(headers: await _buildHeader(useToken: useToken)));
    return response;
  }

  @override
  Future<Response> get(
    String endpoint, {
    bool useToken = false,
    Map<String, dynamic>? query,
  }) async {
    Response response = await client.get(
      host + endpoint,
      queryParameters: query,
      options: Options(
        headers: await _buildHeader(useToken: useToken),
      ),
    );
    return response;
  }

  @override
  Future<Response> put(
    body,
    String endpoint, {
    bool useToken = false,
    Map<String, dynamic>? query,
  }) async {
    Response response = await client.put(
      host + endpoint,
      queryParameters: query,
      data: json.encode(body),
      options: Options(
        headers: await _buildHeader(useToken: useToken),
      ),
    );
    return response;
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storage.read(key: "accessToken");
  }

  @override
  Future<void> storeAccessToken(String token) async {
    return await _storage.write(key: "accessToken", value: token);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: "refreshToken");
  }

  @override
  Future<void> storeRefreshToken(String token) async {
    await _storage.write(key: "token", value: token);
  }

  @override
  Future<void> storeIdentity(String id) async {
    await _storage.write(key: "id", value: id);
  }

  @override
  Future<String?> getIdentity() async {
    return await _storage.read(key: "id");
  }

  @override
  Future<void> deleteToken() async {
    await _storage.deleteAll();
  }
}
