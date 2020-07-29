import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visachecker/services/dataClass.dart';
import 'services/SearchList.dart';
import 'services/Key.dart';
import 'services/currency.dart';
import 'services/searchContent.dart';
import 'drawer.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  static String result = "";
  static Color resultColor;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _passportController = TextEditingController();
  TextEditingController _desController = TextEditingController();

  Future<void> _getDestinationCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String desCountry = prefs.getString('desCountry');
    if (desCountry != null) {
      setState(() {
        _passportController.text = prefs.getString('countryName');
        _desController.text = desCountry;
        prefs.remove('desCountry');
      });
    }
  }

  bool hasKey;

  Future<bool> checkHasKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("hasApiKey");
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      checkHasKey().then((val) {
        hasKey = val;
        print("show currency rate: $hasKey");
      });
      result = "";
      resultColor = Colors.white;
      getAPIKey().then((val) {
        apiKey = val;
      });
    });
    _getDestinationCountry();
  }

  String apiKey;

  Future<String> fetchVisa() async {
    var url =
        "https://passportvisa-api.herokuapp.com/api/${cList[_passportController.text]}/${cList[_desController.text]}";
    var response = await http.get(url);
    var parsedJson = json.decode(response.body);
    var visa = Visa(parsedJson);
    return visa.code;
  }

  Future<String> getAPIKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("CurrencyConverterAPIKey");
  }

  Future<double> getCurrencyRate(String from, String to) async {
    String currencyPair =
        "${currencyList[cList[from]]}_${currencyList[cList[to]]}";
    print(currencyPair);
    var url =
        "https://free.currconv.com/api/v7/convert?q=$currencyPair&compact=ultra&apiKey=$apiKey";
    var response = await http.get(url);
    var parsedJson = json.decode(response.body);
    print(parsedJson);
    var cRate = CurrencyRate(currencyPair, parsedJson);
    return cRate.rate;
  }

  bool isSearchPressed = false;

  int snackBarSeconds = 1;

  double rate;

  String passportCountry, desCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[100],
        ),
        child: drawer(context),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 30, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Search",
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
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 40,
                    right: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextField(
                                controller: _passportController,
                                decoration: InputDecoration(
                                  hintText: 'Enter passport country',
                                ),
                                onTap: () {
                                  setState(() {
                                    isSearchPressed = false;
                                    showSearch(
                                        context: context,
                                        delegate: DataSearch(
                                            controller: _passportController));
                                  });
                                },
                              ),
                            ),
                            Container(
                              child: TextField(
                                controller: _desController,
                                decoration: InputDecoration(
                                  hintText: 'Enter destination country',
                                ),
                                onTap: () {
                                  setState(() {
                                    isSearchPressed = false;
                                    showSearch(
                                        context: context,
                                        delegate: DataSearch(
                                            controller: _desController));
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          FlatButton(
                            child: Icon(Icons.clear_all),
                            onPressed: () {
                              _passportController.text = "";
                              _desController.text = "";
                              setState(() {
                                passportCountry = "";
                                desCountry = "";
                                result = "";
                                isSearchPressed = false;
                              });
                            },
                          ),
                          FlatButton(
                            child: Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                passportCountry = _passportController.text;
                                desCountry = _desController.text;
                                if (passportCountry.length > 0 &&
                                    desCountry.length > 0 &&
                                    passportCountry == desCountry) {
                                  result = "";
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                      duration:
                                          Duration(seconds: snackBarSeconds),
                                      content: Text(
                                          "Passport country and destination country cannot be the same.")));
                                } else if (passportCountry.length == 0 &&
                                    desCountry.length == 0 &&
                                    passportCountry == desCountry) {
                                  result = "";
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                      duration:
                                          Duration(seconds: snackBarSeconds),
                                      content: Text(
                                          "Passport country and destination country cannot be empty.")));
                                } else if (passportCountry == "") {
                                  result = "";
                                  print('Show snackbar');
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                      duration:
                                          Duration(seconds: snackBarSeconds),
                                      content: Text(
                                          "Please enter a passport country.")));
                                } else if (desCountry == "") {
                                  result = "";
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                      duration:
                                          Duration(seconds: snackBarSeconds),
                                      content: Text(
                                          "Please enter a destination country.")));
                                } else {
                                  print(
                                      "passport: ${_passportController.text}");
                                  print("destination: ${_desController.text}");
                                  fetchVisa().then((value) {
                                    result = value;
                                    print(result);
                                    if (result == "VR") {
                                      setState(() {
                                        if (hasKey) {
                                          getCurrencyRate(
                                                  passportCountry, desCountry)
                                              .then((val) => rate = val);
                                        }
                                        resultColor = Colors.red[400];
                                        result = "Visa Required";
                                      });
                                    } else if (result == "VOA" ||
                                        result == "ETA") {
                                      setState(() {
                                        if (hasKey) {
                                          getCurrencyRate(
                                                  passportCountry, desCountry)
                                              .then((val) => rate = val);
                                        }
                                        resultColor = Colors.blue[400];
                                        result = "Visa on arrival";
                                      });
                                    } else if (result == "VF") {
                                      setState(() {
                                        if (hasKey) {
                                          getCurrencyRate(
                                                  passportCountry, desCountry)
                                              .then((val) => rate = val);
                                        }
                                        resultColor = Colors.green[400];
                                        result = "Visa Free";
                                      });
                                    } else {
                                      setState(() {
                                        if (hasKey) {
                                          getCurrencyRate(
                                                  passportCountry, desCountry)
                                              .then((val) => rate = val);
                                        }
                                        resultColor = Colors.green[400];
                                        result = "Visa Free - $result days";
                                      });
                                    }
                                    isSearchPressed = true;
                                  });
                                }
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                isSearchPressed
                    ? hasKey
                        ? FutureBuilder(
                            future:
                                getCurrencyRate(passportCountry, desCountry),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                print("snapshot: $rate");
                                return searchContent(hasKey, passportCountry,
                                    desCountry, result, resultColor, rate);
                              } else {
                                return Container(
                                  height: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          )
                        : searchContent(hasKey, passportCountry, desCountry,
                            result, resultColor, rate)
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
