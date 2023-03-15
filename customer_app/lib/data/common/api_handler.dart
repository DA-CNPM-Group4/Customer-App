import 'dart:convert';
import 'dart:io';
import 'package:customer_app/core/constants/backend_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class APIHandlerInterface {
  init();

  Future<Response> get(String endpoint, {Map<String, dynamic>? query});

  Future<Response> post(var body, String endpoint,
      {Map<String, dynamic>? query});
  Future<Response> put(var body, String endpoint,
      {Map<String, dynamic>? query});

  Future<void> storeToken(String token);

  Future<String?> getToken();

  Future<void> storeIdentity(String token);

  Future<String?> getIdentity();

  Future<void> deleteToken();
}

class APIHandlerImp implements APIHandlerInterface {
  static var host = BackendConstant.host;
  static const _storage = FlutterSecureStorage();
  static final APIHandlerImp _singleton = APIHandlerImp._internal();

  static APIHandlerImp get instance => _singleton;

  static final client = Dio();

  @override
  init() {}

  APIHandlerImp._internal(
      // init here
      );

  factory APIHandlerImp() {
    return _singleton;
  }

  Future<Map<String, String>> _buildHeader({
    bool useToken = false,
    bool refreshToken = false,
  }) async {
    var baseHeader = {
      HttpHeaders.dateHeader: DateTime.now().millisecondsSinceEpoch.toString(),
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      "device": "app"
    };
    if (useToken) {
      String? token = await getToken();
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
  Future<String?> getToken() async {
    return await _storage.read(key: "token");
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: "token");
  }

  @override
  Future<void> storeToken(String token) async {
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
}
