import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:visa_checker/common/constants.dart';

import 'onBoardingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnBoardingScreen())));
    return Container(
      color: kIconBackgroundColor,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
        ),
      ),
    );
  }
}
