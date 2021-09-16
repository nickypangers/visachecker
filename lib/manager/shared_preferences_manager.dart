class SharedPreferencesManager {
  SharedPreferencesManager._privateConstructor();

  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._privateConstructor();

  factory SharedPreferencesManager() {
    return _instance;
  }
}
