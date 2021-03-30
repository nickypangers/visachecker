import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:visa_checker/common/data/countryData.dart';
import 'package:visa_checker/common/models/country.dart';
import 'package:visa_checker/common/models/visa.dart';

Future<String> getVisaStatus(
    Country passportCountry, Country destinationCountry) async {
  var url =
      "https://passportvisa-api.herokuapp.com/api/${passportCountry.countryCode}/${destinationCountry.countryCode}";

  var response = await http.get(url);

  var parsedJson = json.decode(response.body);

  VisaResult visaResult = VisaResult.fromJson(parsedJson);

  return visaResult.code;
}

Future<VisaListResult> getVisaListResult(Country country) async {
  var url =
      "https://passportvisa-api.herokuapp.com/list/api/${country.countryCode}";

  var response = await http.get(url);

  var parsedJson = json.decode(response.body);

  VisaListResult visaListResult = VisaListResult.fromJson(parsedJson);

  return visaListResult;
}

Future<List<Country>> getCountryList() async {
  String data = await rootBundle.loadString("assets/json/countries.json");

  var parsedJson = json.decode(data);

  // print(parsedJson.toString());

  List<Country> list = [];

  parsedJson.forEach((item) {
    Country country = Country.fromJson(item);
    list.add(country);
  });

  print(list[0].countryCode);

  return list;
}

Country getCountryFromCode(String code) {
  // print(countryList.length);
  // print(code);
  return countryList.firstWhere((country) => country.countryCode == code);
}
