import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class FlutterLocalStorageService {

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  static saveUserLoginDetails({required String username, required String password}) async {
    print("Saving user login details.");
    FlutterSecureStorage storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    storage.write(key: 'username', value: username);
    storage.write(key: 'password', value: password);
  }

  static saveUserToken({required String token}) async {
    print("Saving user token.");
    FlutterSecureStorage storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    storage.write(key: 'token', value: token);
  }

  static Future<String> getUserToken() async {
    FlutterSecureStorage storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    return await storage.read(key: 'token') ?? '';
  }

  static Future<String?> getUsername() async {
    FlutterSecureStorage storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    return await storage.read(key: 'username');
  }

  static Future<String?> getPassword() async {
    FlutterSecureStorage storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    return await storage.read(key: 'password');
  }

  static Future deleteUserData() async {
    FlutterSecureStorage(aOptions: _getAndroidOptions()).deleteAll();
  }
}
