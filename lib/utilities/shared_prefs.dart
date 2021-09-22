import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> setValueInPrefs(String key, String value) async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var _res = prefs.setString("$key", value);
  return _res;
}

Future<String> getValueFromPrefs(key) async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  String _res = prefs.getString("$key");
  return _res;
}
