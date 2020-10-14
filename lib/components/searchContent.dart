import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:visa_checker/components/countryDetail.dart';
import 'package:visa_checker/components/currencyWidget.dart';
import 'package:visa_checker/info/info.dart';
import 'package:visa_checker/services/Key.dart';
import 'package:visa_checker/services/dataClass.dart';
import 'package:http/http.dart' as http;

class SearchContent extends StatefulWidget {
  SearchContent({this.passportCountry, this.desCountry});

  final String passportCountry;
  final String desCountry;

  @override
  _SearchContentState createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  String _result = "";
  Color _color;
  int _snackBarSeconds = 1;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<String> _fetchVisa() async {
    var url =
        "https://passportvisa-api.herokuapp.com/api/${cList[widget.passportCountry]}/${cList[widget.desCountry]}";
    var response = await http.get(url);
    var parsedJson = json.decode(response.body);
    var visa = Visa(parsedJson);
    return visa.code;
  }

  _getResult(String passportCountry, String desCountry) {
    if (passportCountry.isEmpty &&
        desCountry.isEmpty &&
        passportCountry == desCountry) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: _snackBarSeconds),
          content: Text(
              "Passport country and destination country cannot be the same.")));
    } else if (passportCountry.isEmpty &&
        desCountry.isEmpty &&
        passportCountry == desCountry) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: _snackBarSeconds),
          content: Text(
              "Passport country and destination country cannot be empty.")));
    } else if (passportCountry == "") {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: _snackBarSeconds),
          content: Text("Please enter a passport country.")));
    } else if (desCountry.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: _snackBarSeconds),
          content: Text("Please enter a destination country.")));
    } else {
      print("passport: $passportCountry");
      print("destination: $desCountry");
      _fetchVisa().then((value) {
        _result = value;
        print(_result);
        setState(() {
          if (_result == "VR") {
            _color = Colors.red[400];
            _result = "Visa Required";
          } else if (_result == "VOA" || _result == "ETA") {
            return [Colors.blue[400], "Visa on arrival"];
          } else if (_result == "VF") {
            return [Colors.green[400], "Visa Free"];
          } else {
            return [Colors.green[400], "Visa Free - $_result days"];
          }
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getResult(widget.passportCountry, widget.desCountry);
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
              CountryDetail(
                isPassport: true,
                country: widget.passportCountry,
              ),
              CountryDetail(
                isPassport: false,
                country: widget.desCountry,
              ),
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
