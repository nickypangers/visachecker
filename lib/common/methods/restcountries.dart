import 'dart:async';
import 'dart:convert';

import 'package:visa_checker/common/models/country.dart';
import 'package:http/http.dart' as http;
import 'package:visa_checker/common/models/restcountries.dart';

Future<String> getCapital(Country country) async {
  var url = "https://restcountries.eu/rest/v2/name/${country.countryName}";

  var response = await http.get(Uri.parse(url));

  var parsedJson = json.decode(response.body);

  // print(parsedJson);

  if (parsedJson == null) {
    print(country.countryName);
    return "null";
  }

  RestCountries restCountry = RestCountries.fromJson(parsedJson[0]);

  return restCountry.capital;
}
