import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visachecker/manager/app_manager.dart';
import 'package:visachecker/common/models/country.dart';
import 'package:visachecker/common/models/country_list.dart';
import 'package:visachecker/common/models/navigation.dart';
import 'package:visachecker/common/models/visa.dart';
import 'package:visachecker/common/screens/content_screen.dart';
import 'package:visachecker/common/screens/onboarding_screen.dart';
import 'package:visachecker/common/utils/constants.dart';
import 'package:visachecker/manager/request_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _initData(BuildContext context) async {
    debugPrint("Environment: $kEnvironment");
    debugPrint("Endpoint: ${RequestManager().getEndpoint("")}");

    bool isLatestVersion = await AppManager().isLatestVersion();
    debugPrint("Is Latest Version: $isLatestVersion");

    if (!isLatestVersion) {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Update Available"),
              content: Text("Please update to the latest version"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("Update"),
                  onPressed: () async {
                    // Navigator.of(context).pop();
                    if (!await launch(AppManager().getAppUrl()))
                      throw 'Could not launch';
                  },
                ),
                ElevatedButton(
                  child: Text("Later"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    VisaData visaData = await RequestManager().getVisaData();
    Provider.of<VisaData>(context, listen: false).setData(visaData);

    CountryList countryList = await RequestManager().getCountryList();
    Provider.of<CountryList>(context, listen: false)
        .setCountryList(countryList);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? code = preferences.getString("country");

    debugPrint("init data: get preferences \"country\"");

    Country country = code != null
        ? countryList.getCountryByCode(code)
        : countryList.getCountryList![0];
    Provider.of<Country>(context, listen: false).setCountry(context, country);

    bool isReturnUser = await _isReturningUser();

    return isReturnUser;
  }

  Future<bool> _isReturningUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isReturning = prefs.getBool("isReturning") ?? false;
    return isReturning;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _initData(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                Timer(const Duration(seconds: 3), () {
                  Provider.of<NavigationState>(context, listen: false)
                      .setNavigation(NavigationEvents.homePageClickedEvent);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ContentScreen()),
                  );
                });
              } else {
                Timer(const Duration(seconds: 3), () {
                  Provider.of<NavigationState>(context, listen: false)
                      .setNavigation(NavigationEvents.homePageClickedEvent);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OnBoardingScreen()),
                  );
                });
              }
            }
            return Container(
              color: kIconBackgroundColor,
              child: const Center(
                child: SpinKitChasingDots(
                  color: Colors.white,
                ),
              ),
            );
          }),
    );
  }
}
