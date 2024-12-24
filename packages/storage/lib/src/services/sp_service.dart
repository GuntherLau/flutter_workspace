import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SpService {

  static final SpService _instance = SpService._internal();
  SpService._internal();
  static SpService get instance => _instance;

  late SharedPreferences _preferences;

  Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  void setString(String key, String value) {
    _preferences.setString(key, value);
  }
  String getString(String key, {String? defValue} ) {
    return _preferences.getString(key) ?? (defValue ?? '');
  }

  void setBool(String key, bool value) {
    _preferences.setBool(key, value);
  }
  bool getBool(String key, {bool? defValue}) {
    return _preferences.getBool(key) ?? (defValue ?? false);
  }

  void setInt(String key, int value) {
    _preferences.setInt(key, value);
  }
  int getInt(String key, {int? defValue}) {
    return _preferences.getInt(key) ?? (defValue ?? 0);
  }

  void setDouble(String key, double value) {
    _preferences.setDouble(key, value);
  }
  double getDouble(key, {double? defValue}) {
    return _preferences.getDouble(key) ?? (defValue ?? 0);
  }

  void setStringList(String key, List<String> value) {
    _preferences.setStringList(key, value);
  }
  List<String> getStringList(key) {
    return _preferences.getStringList(key) ?? [];
  }

  void setJson(String key, Object value) {
    String json = jsonEncode(value);
    _preferences.setString(key, json);
  }
  Object getJson(String key) {
    String value = getString(key, defValue: '{}');
    return jsonDecode(value);
  }

  bool exists(String key) {
    return _preferences.containsKey(key);
  }
  void remove(String key) {
    _preferences.remove(key);
  }
  void clean() {
    _preferences.clear();
  }

}