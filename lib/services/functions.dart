import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

openBrowserTab(String url) async {
  await FlutterWebBrowser.openWebPage(
      url: url, androidToolbarColor: Colors.white);
}
