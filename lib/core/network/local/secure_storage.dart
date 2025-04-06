import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<void> saveData({
    required String key,
    required String value,
  }) async {
    return await secureStorage.write(key: key, value: value);
  }

  Future<String?> getData({required String key}) async {
    return secureStorage.read(key: key);
  }

  Future<void> delete({required String key}) async {
    return secureStorage.delete(key: key);
  }
}
