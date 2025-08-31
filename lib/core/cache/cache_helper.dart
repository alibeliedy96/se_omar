import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

abstract class StorageKeys {
  StorageKeys();

  // Declare all storage keys here
  static const String token = "TOKEN";
  static const String language = "lan";
}

class CacheHelper {
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // ----------------- Token -----------------
  static Future<void> setToken(String token) async {
    await secureStorage.write(key: StorageKeys.token, value: token);
  }

  static Future<String?> getToken() async {
    try {
      return await secureStorage.read(key: StorageKeys.token);
    } catch (e) {
      debugPrint("SecureStorage getToken error: $e");
      await secureStorage.delete(key: StorageKeys.token);
      return null;
    }
  }

  // ----------------- Language -----------------
  static Future<void> setLanguage(String language) async {
    await secureStorage.write(key: StorageKeys.language, value: language);
  }

  static Future<String?> getLanguage() async {
    try {
      return await secureStorage.read(key: StorageKeys.language);
    } catch (e) {
      debugPrint("SecureStorage getLanguage error: $e");
      await secureStorage.delete(key: StorageKeys.language);
      return null;
    }
  }

  // ----------------- Generic -----------------
  static Future<void> saveData({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }

  static Future<String?> getData({required String key}) async {
    try {
      return await secureStorage.read(key: key);
    } catch (e) {
      debugPrint("SecureStorage getData($key) error: $e");
      await secureStorage.delete(key: key);
      return null;
    }
  }

  static Future<void> removeData({required String key}) async {
    await secureStorage.delete(key: key);
  }

  static Future<void> clearAll() async {
    await secureStorage.deleteAll();
  }
}
