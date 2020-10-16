import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:visa_checker/info/info.dart';
import 'package:visa_checker/services/Key.dart';
import 'package:visa_checker/services/currency.dart';
import 'package:visa_checker/services/dataClass.dart';
import 'package:visa_checker/services/prefs.dart';

class CurrencyWidget extends StatefulWidget {
  final String from;
  final String to;

  CurrencyWidget({this.from, this.to});

  @override
  _CurrencyWidgetState createState() => _CurrencyWidgetState();
}

class _CurrencyWidgetState extends State<CurrencyWidget> {
  Future<double> getCurrencyRate(String from, String to) async {
    String _apiKey = await getAPIKey(currencyKey);
    print("Currency API Key: $_apiKey");
    String _currencyPair =
        "${currencyList[cList[from]]}_${currencyList[cList[to]]}";
    print(_currencyPair);
    var url =
        "https://free.currconv.com/api/v7/convert?q=$_currencyPair&compact=ultra&apiKey=$_apiKey";
    var response = await http.get(url);
    var parsedJson = json.decode(response.body);
    print(parsedJson);
    var cRate = CurrencyRate(_currencyPair, parsedJson);
    print("status: ${cRate.status}");
    if (cRate.status == 400) {
      return -1;
    } else {
      print(cRate.rate);
      return cRate.rate;
    }
  }

  double rate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCurrencyRate(widget.from, widget.to),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print("snapshot: $rate");
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Currency Exchange Rate",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: (snapshot.data == -1)
                      ? Container(
                          child: Text("API Key is incorrect."),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "1 ${currencyList[cList[widget.from]]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "${snapshot.data} ${currencyList[cList[widget.to]]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                ),
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
