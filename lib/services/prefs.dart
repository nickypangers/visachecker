import 'package:shared_preferences/shared_preferences.dart';

Future<String> getAPIKey(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}
