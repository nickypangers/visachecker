import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:visa_checker/common/data/countryData.dart';
import 'package:visa_checker/common/models/country.dart';

Future<bool> setSelectedCountry(Country country) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String countryString = jsonEncode(country);

  prefs.setString('selectedCountry', countryString);

  return true;
}

Future<Country> getSelectedCountry() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('selectedCountry') == false) {
    return countryList[0];
  }

  String countryString = prefs.getString('selectedCountry');

  var parsedJson = json.decode(countryString);

  return Country.fromJson(parsedJson);
}
