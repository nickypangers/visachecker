import 'package:package_info/package_info.dart';
import 'package:visachecker/manager/request_manager.dart';

class AppManager {
  AppManager._privateConstructor();

  static final AppManager _instance = AppManager._privateConstructor();

  factory AppManager() => _instance;

  Future<bool> isAppLatest() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String latestAppVersion = await RequestManager().getLatestAppVersion();
    return packageInfo.version == latestAppVersion;
  }
}
