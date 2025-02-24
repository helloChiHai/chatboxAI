import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stock_flutter/models/user_model.dart';

class StorageService {
  static const storage = FlutterSecureStorage();

  static Future<void> saveEmailUser(String emailUser) async {
    await storage.write(key: 'emailUser', value: emailUser);
  }

  static Future<String?> getEmailUser() async {
    return await storage.read(key: 'emailUser');
  }

/////////

  static Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: 'token');
  }
}
