// ad unit id: ca-app-pub-9340573218005429/8126584685

import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9340573218005429~5971013454";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9340573218005429~5117277969";
    } else {
      throw new UnsupportedError("Unsupported Platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9340573218005429/8126584685";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9340573218005429/9603317888";
    } else {
      throw new UnsupportedError("Unsupported Platform");
    }
  }
}
