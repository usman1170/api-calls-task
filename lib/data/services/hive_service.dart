import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  late Box<String> _tokenBox;

  Future<void> _initBox() async {
    if (!Hive.isBoxOpen('tokenBox')) {
      _tokenBox = await Hive.openBox<String>('tokenBox');
    } else {
      _tokenBox = Hive.box<String>('tokenBox');
    }
  }

  Future<void> storeToken(String token) async {
    await _initBox();
    await _tokenBox.put('authToken', token);
    log("Token stored in Hive: $token");
  }

  Future<String?> getToken() async {
    await _initBox();
    final token = _tokenBox.get('authToken');
    log("Retrieved token from Hive: $token");
    return token;
  }

  Future<bool> isLoggedIn() async {
    await _initBox();
    return _tokenBox.containsKey('authToken');
  }

  Future<void> clearToken() async {
    await _initBox();
    await _tokenBox.delete('authToken');
    log("Token cleared from Hive");
  }
}
