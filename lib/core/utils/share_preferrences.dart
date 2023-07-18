// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // as String
  static const String USER_TOKEN = 'userToken';

   /// Store String value locally.
  /// [key] The key of saved value, which will be used later when getting
  /// the value.
  /// [value] The value to be saved
  static Future<bool> saveStringValue(String key, String value) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  /// Get stored value from local storage.
  /// [key] The key to identify the value we get.
  static Future<String>getStringValue(String key) async {
    final preferences = await SharedPreferences.getInstance();
    final value = preferences.getString(key) ?? '';
    return value;
  }
}
