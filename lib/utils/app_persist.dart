import 'package:shared_preferences/shared_preferences.dart';

class AppPersist {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static Future<bool> setBoolean(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static bool getBoolean(String key, bool defValue) {
    return _prefsInstance?.getBool(key) ?? defValue;
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static String getString(String key, String defValue) {
    return _prefsInstance?.getString(key) ?? defValue;
  }

  static Future<bool> setDouble(String key, double value) async {
    var prefs = await _instance;
    return prefs.setDouble(key, value);
  }

  static double getDouble(String key) {
    return _prefsInstance?.getDouble(key) ?? 0.0;
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);
  }

  static int getInt(String key, int defValue) {
    return _prefsInstance?.getInt(key) ?? defValue;
  }

  void remove(key) async {
    var prefs = await _instance;
    prefs.remove(key);
  }

  static void clear() async {
    await _prefsInstance!.clear();
  }
}
