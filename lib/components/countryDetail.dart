import 'package:flutter/material.dart';
import 'package:visa_checker/components/countryFlag.dart';

class CountryDetail extends StatelessWidget {
  CountryDetail({this.isPassport, this.country});

  final bool isPassport;
  final String country;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Center(
            child: Text(
              isPassport ? "Passport" : "Destination",
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
            child: CountryFlag(country: country),
          ),
        ),
      ],
    );
  }
}
