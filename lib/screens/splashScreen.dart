import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:visa_checker/common/methods/shared_preferences.dart';
import 'package:visa_checker/common/methods/visa.dart';
import 'package:visa_checker/common/constants.dart';
import 'package:visa_checker/common/data/countryData.dart';
import 'package:visa_checker/common/models/country.dart';
import 'package:visa_checker/common/models/navigation.dart';
import 'package:visa_checker/common/models/visa.dart';

import 'onBoardingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<Country> _initSelectedCountry() async {
    countryList = await getCountryList();

    Country country = await getSelectedCountry();

    var visaListResult = await getVisaListResult(country);

    // print("visa list result: ${visaListResult.vf}");

    Provider.of<VisaList>(context, listen: false).setVisaList(visaListResult);

    return country;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _initSelectedCountry(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data is Country) {
              print("provider set");
              // Country _country = Provider.of<Country>(context, listen: false);
              Timer(Duration(seconds: 3), () {
                Provider.of<Country>(context, listen: false)
                    .setCountry(snapshot.data);
                Provider.of<NavigationState>(context, listen: false)
                    .setNavigation(NavigationEvents.HomePageClickedEvent);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OnBoardingScreen()),
                );
              });
            }
            return Container(
              color: kIconBackgroundColor,
              child: Center(
                child: SpinKitChasingDots(
                  color: Colors.white,
                ),
              ),
            );
          }),
    );
  }
}
