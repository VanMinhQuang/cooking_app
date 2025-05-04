
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
static SharedPrefsRepository? _instance;
static SharedPreferences? _sharedPreferences;

// Private constructor
SharedPrefsRepository._();

// Factory constructor to return the same instance
factory SharedPrefsRepository() {
_instance ??= SharedPrefsRepository._();
return _instance!;
}

// Initialize SharedPreferences
Future<void> init() async {
_sharedPreferences ??= await SharedPreferences.getInstance();
}

// Get methods
String getString(String key, {String defaultValue = ''}) {
return _sharedPreferences?.getString(key) ?? defaultValue;
}

bool getBool(String key, {bool defaultValue = false}) {
return _sharedPreferences?.getBool(key) ?? defaultValue;
}

int getInt(String key, {int defaultValue = 0}) {
return _sharedPreferences?.getInt(key) ?? defaultValue;
}

double getDouble(String key, {double defaultValue = 0.0}) {
return _sharedPreferences?.getDouble(key) ?? defaultValue;
}

List<String> getStringList(String key, {List<String> defaultValue = const []}) {
return _sharedPreferences?.getStringList(key) ?? defaultValue;
}

// Set methods
Future<bool> setString(String key, String value) async {
return await _sharedPreferences?.setString(key, value) ?? false;
}

Future<bool> setBool(String key, bool value) async {
return await _sharedPreferences?.setBool(key, value) ?? false;
}

Future<bool> setInt(String key, int value) async {
return await _sharedPreferences?.setInt(key, value) ?? false;
}

Future<bool> setDouble(String key, double value) async {
return await _sharedPreferences?.setDouble(key, value) ?? false;
}

Future<bool> setStringList(String key, List<String> value) async {
return await _sharedPreferences?.setStringList(key, value) ?? false;
}

// Remove and clear methods
Future<bool> remove(String key) async {
return await _sharedPreferences?.remove(key) ?? false;
}

Future<bool> clear() async {
return await _sharedPreferences?.clear() ?? false;
}

// Check if key exists
bool containsKey(String key) {
return _sharedPreferences?.containsKey(key) ?? false;
}
}