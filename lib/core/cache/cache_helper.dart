import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class StorageKeys {
  StorageKeys();

  // Declare all storage keys here
  static const String token = "TOKEN";
  static const String language = "lan";
}

class CacheHelper {
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Future<void> setToken(String token) async {
    await secureStorage.write(key: StorageKeys.token, value: token);
  }

  static Future<String?> getToken() async {
    return await secureStorage.read(key: StorageKeys.token);
  }

  static Future<void> setLanguage(String language) async {
    await secureStorage.write(key: StorageKeys.language, value: language);
  }

  static Future<String?> getLanguage() async {
    return await secureStorage.read(key: StorageKeys.language);
  }

  static Future<void> saveData({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }

  static Future<String?> getData({required String key}) async {
    return await secureStorage.read(key: key);
  }

  static Future<void> removeData({required String key}) async {
    await secureStorage.delete(key: key);
  }

  static Future<void> clearAll() async {
    await secureStorage.deleteAll();
  }
}
