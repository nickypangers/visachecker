import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visa_checker/info/info.dart';
import 'package:visa_checker/services/functions.dart';
import 'package:visa_checker/services/prefs.dart';

import 'settings.dart';

class WeatherAPIScreen extends StatefulWidget {
  @override
  _WeatherAPIScreenState createState() => _WeatherAPIScreenState();
}

class _WeatherAPIScreenState extends State<WeatherAPIScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _apiController = TextEditingController();

  bool _hasKey = false;

  Future<bool> checkHasKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var check = prefs.getBool(showWeatherKey);
    (check != null) ? check = check : check = false;
    return check;
  }

  Future<void> _setweatherKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("weatherKey", key);
  }

  @override
  void initState() {
    super.initState();
    getAPIKey("weatherKey").then((val) {
      if (val != null) {
        _apiController..text = val;
      }
    });
    checkHasKey().then((val) {
      setState(() {
        _hasKey = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      print(_apiController.text);
                      setState(() {
                        if (_apiController.text.isEmpty) {
                          _hasKey = false;
                        }
                      });
                      setHasKey(showWeatherKey, _hasKey);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsScreen()));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Weather API",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SwitchListTile(
              title: Text("Show Weather in Search"),
              value: _hasKey,
              onChanged: (val) {
                setState(() {
                  _hasKey = val;
                  print(_hasKey);
                  setHasKey(showWeatherKey, _hasKey);
                });
              },
            ),
            _hasKey
                ? Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: Container(
                      child: TextField(
                        autocorrect: false,
                        decoration:
                            InputDecoration(labelText: 'Weather API Key'),
                        controller: _apiController,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        onSubmitted: (val) {
                          if (val.length > 0) {
                            _setweatherKey(val);
                            setAPIKey("weatherKey", val);
                          } else {
                            setState(() => _hasKey = false);
                          }
                        },
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Text("""
              In order to show weather data, you will need to have an API Key from openweathermap.org (not associated).\n
              If you do not have an account, please register a free account in order to retreive your API key and paste it into the text field above.
              """),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Container(
                child: Center(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                      side: BorderSide(color: Colors.black, width: 2),
                    ),
                    child: Text("Get Weather API Key"),
                    onPressed: () =>
                        openBrowserTab("https://openweathermap.org/"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
