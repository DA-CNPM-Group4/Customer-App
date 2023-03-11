import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class APIHandlerInterface {
  init();

  Future<Response> get(String endpoint, Map<String, dynamic> query);

  Future<Response> post(var body, String endpoint);
  Future<Response> put(var body, String endpoint);

  Future<void> storeToken(String token);

  Future<String?> getToken();

  Future<void> deleteToken();
}

class APIHandlerImp implements APIHandlerInterface {
  static var host = "https://ubercloneserver.herokuapp.com/";
  static const _storage = FlutterSecureStorage();
  static final APIHandlerImp _singleton = APIHandlerImp._internal();
  static final client = Dio();

  APIHandlerImp._internal();

  factory APIHandlerImp() {
    return _singleton;
  }

  Future<Map<String, String>> _buildHeader({bool refreshToken = false}) async {
    String? token = await getToken();

    var baseHeader = {
      HttpHeaders.dateHeader: DateTime.now().millisecondsSinceEpoch.toString(),
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      "device": "app"
    };
    if (token != "") {
      print("[API] Token: ${token ?? ''}");
      baseHeader["token"] = "$token";
    }
    return baseHeader;
  }

  static Uri buildUrlWithQuery(String endpoint, Map<String, dynamic> query) {
    return query.isEmpty
        ? Uri.parse(host + endpoint).replace(queryParameters: query)
        : Uri.parse(host + endpoint);
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: "token");
  }

  @override
  Future<String?> getToken() async {
    return await _storage.read(key: "token");
  }

  @override
  init() {}

  @override
  Future<Response> post(var body, String endpoint) async {
    Response response = await client.post(host + endpoint,
        data: json.encode(body),
        options: Options(headers: await _buildHeader()));
    print(response);
    return response;
  }

  @override
  Future<void> storeToken(String token) async {
    await _storage.write(key: "token", value: token);
  }

  @override
  Future<Response> get(String endpoint, Map<String, dynamic> query) async {
    Response response = await client.get(host + endpoint,
        queryParameters: query,
        options: Options(headers: await _buildHeader()));
    print("\n\n" + endpoint);
    print(response);
    return response;
  }

  @override
  Future<Response> put(body, String endpoint) async {
    Response response = await client.put(host + endpoint,
        data: json.encode(body),
        options: Options(headers: await _buildHeader()));
    print("\n\n" + endpoint);
    print(response);
    return response;
  }
}
