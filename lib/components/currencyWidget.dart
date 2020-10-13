import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:visa_checker/services/Key.dart';
import 'package:visa_checker/services/currency.dart';
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
    String apiKey = await getAPIKey("CurrencyConverterAPIKey");
    String currencyPair =
        "${currencyList[cList[from]]}_${currencyList[cList[to]]}";
    print(currencyPair);
    var url =
        "https://free.currconv.com/api/v7/convert?q=$currencyPair&compact=ultra&apiKey=$apiKey";
    var response = await http.get(url);
    var parsedJson = json.decode(response.body);
    print(parsedJson);
    var cRate = CurrencyRate(currencyPair, parsedJson);
    print("status: ${cRate.status}");
    if (cRate.status == 400) {
      return -1;
    } else {
      return cRate.rate;
    }
  }

  double rate;

  @override
  void initState() {
    super.initState();
    // getCurrencyRate(widget.from, widget.to).then((val) => rate = val);
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
                  child: (rate == -1 || rate == null)
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
                              "$rate ${currencyList[cList[widget.to]]}",
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
