import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future writeSecureData(String key, String value) async {
    var data = await _storage.write(key: key, value: value);
    return data;
  }

  Future readSecureData(String key) async {
    var data = await _storage.read(key: key);
    return data;
  }

  Future deleteSecureData(String key) async {
    var data = await _storage.delete(key: key);
    return data;
  }
}