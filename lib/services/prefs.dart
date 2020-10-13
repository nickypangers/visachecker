import 'package:shared_preferences/shared_preferences.dart';

Future<String> getAPIKey(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<bool> checkHasKey(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var val = prefs.getBool(key);
  return (val == null) ? false : val;
}

Future<void> setHasKey(String key, bool val) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, val);
}
