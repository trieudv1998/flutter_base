// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // as String
  static const String ACCESS_TOKEN = 'accessToken';
  static const String POINTS_LIST = 'pointsList';
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

  static Future<void> removeByKey(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
  static Future<void> savePointsList(List<Map<String, double>> points) async {
    final prefs = await SharedPreferences.getInstance();
    final String pointsJson = jsonEncode(points);
    await prefs.setString(POINTS_LIST, pointsJson);
  }

  /// Retrieve the list of points.
  static Future<List<Map<String, double>>?> getPointsList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? pointsJson = prefs.getString(POINTS_LIST);
    if (pointsJson != null) {
      final List<dynamic> pointsList = jsonDecode(pointsJson);
      return pointsList.map((point) => Map<String, double>.from(point)).toList();
    } else {
      return null;
    }
  }
}
