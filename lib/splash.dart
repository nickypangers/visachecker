import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

import 'services/SearchList.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future seen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = prefs.getBool('seen');
    print("seen: $_seen");
    if (_seen == null) {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => IntroScreen()));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => HomeScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    seen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Loading..."),
      ),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  setSeen(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', state);
  }

  setCountry(String country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('countryName', country);
  }

  TextEditingController _controller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Welcome to Visa Checker"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 255,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your passport country",
                  ),
                  controller: _controller,
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate: DataSearch(controller: _controller));
                  },
                ),
              ),
              FlatButton(
                child: Text("Enter"),
                onPressed: () {
                  setSeen(true);
                  setCountry(_controller.text);
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              HomeScreen()));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
