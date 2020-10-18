// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:visa_checker/info/info.dart';
import 'package:visa_checker/services/WeatherData.dart';
import 'package:visa_checker/services/prefs.dart';
import 'package:http/http.dart' as http;

class WeatherWidget extends StatefulWidget {
  WeatherWidget({this.from, this.to});
  final String from;
  final String to;
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Future<dynamic> _getWeatherData(String location) async {
    String _apiKey = await getAPIKey(weatherKey);
    // to = "united kingdom";
    print("Weather Key: $_apiKey");
    var url =
        "https://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$location";
    print(url);
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    return weatherDataFromJson(response.body);
  }

  Future<List<WeatherData>> _getWeather() async {
    WeatherData fromWeather, toWeather;
    await _getWeatherData(widget.from).then((val) => fromWeather = val);
    await _getWeatherData(widget.to).then((val) => toWeather = val);
    print(fromWeather.current.tempC);
    print(toWeather.current.tempC);
    return [fromWeather, toWeather];
  }

  @override
  void initState() {
    super.initState();
    _getWeatherData(widget.from).then((value) => print(value.current.tempC));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print("data type: ${snapshot.hasData}");
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    child: Text(
                      "Weather",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "${snapshot.data[0].current.tempC}",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${snapshot.data[1].current.tempC}",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 64,
                            height: 64,
                            child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                    "https:${snapshot.data[0].current.condition.icon}")),
                          ),
                          SizedBox(
                            width: 64,
                            height: 64,
                            child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                    "https:${snapshot.data[1].current.condition.icon}")),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            print(snapshot.data);
            return Container(
              height: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
