import 'package:flutter/material.dart';
import 'package:visa_checker/info/info.dart';
import 'package:visa_checker/models/country.dart';
import 'package:visa_checker/models/weather.dart';
import 'package:visa_checker/services/Key.dart';
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
  Future<dynamic> _getWeatherData(dynamic coord) async {
    String _apiKey = await getAPIKey(weatherKey);
    String _latlng = "${coord[0]},${coord[1]}";
    print("latlng: $_latlng");
    print("Weather Key: $_apiKey");
    var url =
        "https://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$_latlng";
    print(url);
    var response = await http.get(url);
    print("weather data status code: ${response.statusCode}");
    print(response.body);
    return weatherDataFromJson(response.body);
  }

  Future<List<WeatherData>> _getWeather() async {
    WeatherData fromWeather, toWeather;
    var fromCoord = await _getCountryLatLong(widget.from);
    var toCoord = await _getCountryLatLong(widget.to);
    await _getWeatherData(fromCoord).then((val) => fromWeather = val);
    await _getWeatherData(toCoord).then((val) => toWeather = val);
    print(isCelcius ? fromWeather.current.tempC : fromWeather.current.tempF);
    print(isCelcius ? toWeather.current.tempC : toWeather.current.tempF);
    return [fromWeather, toWeather];
  }

  Future<dynamic> _getCountryLatLong(String country) async {
    var code = cList[country];
    print("code: $code");
    var url = "https://restcountries.eu/rest/v2/alpha/$code?fields=latlng";
    print(url);
    var response = await http.get(url);
    print("country latlng status code: ${response.statusCode}");
    print("body: ${response.body}");
    var data = countryFromJson(response.body);
    print(data.runtimeType);
    return data.latlng;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
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
                              isCelcius
                                  ? "${snapshot.data[0].current.tempC}°C"
                                  : "${snapshot.data[0].current.tempF}°F",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              isCelcius
                                  ? "${snapshot.data[1].current.tempC}°C"
                                  : "${snapshot.data[1].current.tempF}°F",
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
                )
              ],
            );
          } else {
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
