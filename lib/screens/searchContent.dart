import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:visa_checker/components/currencyWidget.dart';
import 'package:visa_checker/components/searchWidgets.dart';
import 'package:visa_checker/info/info.dart';
import 'package:visa_checker/services/Key.dart';
import 'package:visa_checker/services/dataClass.dart';
import 'package:visa_checker/services/prefs.dart';

class SearchContent extends StatefulWidget {
  SearchContent({this.passportCountry, this.desCountry});

  final String passportCountry;
  final String desCountry;

  @override
  _SearchContentState createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  Future<String> _fetchVisa() async {
    var url =
        "https://passportvisa-api.herokuapp.com/api/${cList[widget.passportCountry]}/${cList[widget.desCountry]}";
    var response = await http.get(url);
    var parsedJson = json.decode(response.body);
    var visa = Visa(parsedJson);
    return visa.code;
  }

  String _result;
  Color _color;

  @override
  void initState() {
    super.initState();
    getAPIKey("currencyConverterAPIKey");
    _fetchVisa().then((value) {
      _result = value;
      print(_result);
      setState(() {
        if (_result == "VR") {
          _color = Colors.red[400];
          _result = "Visa Required";
        } else if (_result == "VOA" || _result == "ETA") {
          _color = Colors.blue[400];
          _result = "Visa on arrival";
        } else if (_result == "VF") {
          _color = Colors.green[400];
          _result = "Visa Free";
        } else {
          _color = Colors.green[400];
          _result = "Visa Free - $_result days";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              countryDetail("Passport", widget.passportCountry),
              countryDetail("Destination", widget.desCountry),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: _color,
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    _result,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          (showCurrency == true)
              ? CurrencyWidget(
                  from: widget.passportCountry,
                  to: widget.desCountry,
                )
              : Container(),
        ],
      ),
    );
  }
}
