import 'dart:convert';

import 'package:http/http.dart' as http;
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
