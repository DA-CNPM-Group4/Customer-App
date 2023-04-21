import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<String?> getAccessToken() async {
    return await storage.read(key: "accessToken");
  }

  static Future<void> storeAccessToken(String token) async {
    return await storage.write(key: "accessToken", value: token);
  }

  static Future<String?> getRefreshToken() async {
    return await storage.read(key: "refreshToken");
  }

  static Future<void> storeRefreshToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  static Future<void> storeIdentity(String id) async {
    await storage.write(key: "id", value: id);
  }

  static Future<String?> getIdentity() async {
    return await storage.read(key: "id");
  }

  static Future<void> deleteToken() async {
    await storage.deleteAll();
  }
}
