import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  Future<void> writeSecureToken(String key, String value) async {
    // I'm not exactly sure how you get the data from storage.write, because it has a type of Future<void>
    // So the whole function should be await storage.write(key: key, value: value);
    await storage.write(key: key, value: value);
  }

  Future<String?> readSecureToken(String key) async {
    return await storage.read(key: key);
  }

  Future<void> deleteSecureToken(String key) async {
    // Same here: delete is a type of void, so it shouldn't return anything
    await storage.delete(key: key);
  }
}