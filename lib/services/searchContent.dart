import 'package:flutter/material.dart';
import 'package:visa_checker/services/currency.dart';
import 'Key.dart';

Widget countryFlag(String country) {
  return SizedBox(
    width: 64,
    height: 64,
    child: FittedBox(
      fit: BoxFit.fill,
      child: (country.length > 0)
          ? Image.network(
              "https://www.countryflags.io/${cList[country]}/flat/64.png")
          : Container(),
    ),
  );
}

Widget countryDetail(String category, String country) {
  return Column(
    children: <Widget>[
      Container(
        child: Center(
          child: Text(
            category,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      Container(
        child: Center(
          child: countryFlag(country),
        ),
      ),
    ],
  );
}

Widget searchContent(bool hasKey, String passportCountry, String desCountry,
    String result, Color color, double rate) {
  print("rate: $rate");
  return Padding(
    padding: EdgeInsets.only(
      top: 10,
    ),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            countryDetail("Passport", passportCountry),
            countryDetail("Destination", desCountry),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: color,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  result,
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
        (hasKey == true)
            ? currencyResult(passportCountry, desCountry, rate)
            : Container(),
      ],
    ),
  );
}

Widget currencyResult(String passportCountry, String desCountry, double rate) {
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
                    "1 ${currencyList[cList[passportCountry]]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "$rate ${currencyList[cList[desCountry]]}",
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
}
