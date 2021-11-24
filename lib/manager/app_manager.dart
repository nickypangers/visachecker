import 'package:package_info/package_info.dart';
import 'package:visachecker/manager/request_manager.dart';
import 'dart:io' show Platform;

class AppManager {
  AppManager._privateConstructor();

  static final AppManager _instance = AppManager._privateConstructor();

  factory AppManager() {
    return _instance;
  }

  String getAppUrl() {
    if (Platform.isIOS) {
      return 'https://apps.apple.com/us/app/visa-checker/id1498797587';
    } else if (Platform.isAndroid) {
      return 'https://play.google.com/store/apps/details?id=com.nickypangers.visacheckertravel';
    } else {
      return 'https://www.visachecker.com';
    }
  }

  Future<bool> isLatestVersion() async {
    PackageInfo info = await PackageInfo.fromPlatform();

    String currentAppVersion = info.version;
    String latestAppVersion = await RequestManager().getLatestAppVersion();

    if (currentAppVersion != latestAppVersion) {
      return false;
    }
    return true;
  }
}
