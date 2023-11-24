import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  void saveStoreInt(String key, int currentLevel) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, currentLevel);
  }

  Future<int> getStoreInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }
}
