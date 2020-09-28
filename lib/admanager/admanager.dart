// ad unit id: ca-app-pub-9340573218005429/8126584685

import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';

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

  static String get homeBannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9340573218005429/8126584685";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9340573218005429/3876735522";
    } else {
      throw new UnsupportedError("Unsupported Platform");
    }
  }

  static String get searchBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9340573218005429/6964071470';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9340573218005429/4259878909';
    } else {
      throw new UnsupportedError("Unsupported Platform");
    }
  }
}

AdmobBannerSize bannerSize = AdmobBannerSize.BANNER;
