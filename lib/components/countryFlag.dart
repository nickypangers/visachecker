import 'package:flutter/material.dart';
import 'package:visa_checker/services/Key.dart';

class CountryFlag extends StatelessWidget {
  CountryFlag({this.country});

  final String country;

  @override
  Widget build(BuildContext context) {
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
}
