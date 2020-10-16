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

  Future<String> _fetchVisa() async {
    var url =
        "https://passportvisa-api.herokuapp.com/api/${cList[widget.passportCountry]}/${cList[widget.desCountry]}";
    var response = await http.get(url);
    var parsedJson = json.decode(response.body);
    var visa = Visa(parsedJson);
    return visa.code;
  }

  Future<List> _getResult(String passportCountry, String desCountry) async {
    if (passportCountry == desCountry) {
      return [
        -1,
        "Passport country and destination country cannot be the same."
      ];
    } else if (passportCountry.isEmpty && desCountry.isEmpty) {
      return [-1, "Passport country and destination country cannot be empty."];
    } else if (passportCountry == "") {
      return [-1, "Please enter a passport country."];
    } else if (desCountry.isEmpty) {
      return [-1, "Please enter a destination country."];
    } else {
      print("passport: $passportCountry");
      print("destination: $desCountry");
      _result = await _fetchVisa();
      print(_result);
      if (_result == "VR") {
        return [Colors.red[400], "Visa Required"];
      } else if (_result == "VOA" || _result == "ETA") {
        return [Colors.blue[400], "Visa On Arrival"];
      } else if (_result == "VF") {
        return [Colors.green[400], "Visa Free"];
      } else {
        return [Colors.green[400], "Visa Free - $_result days"];
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getResult(widget.passportCountry, widget.desCountry),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data[0] != -1) {
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
                          color: snapshot.data[0],
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              snapshot.data[1],
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
            } else {
              return Container(
                height: 100,
                child: Center(
                  child: Text(snapshot.data[1]),
                ),
              );
            }
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
