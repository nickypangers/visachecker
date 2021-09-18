import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:visachecker/common/models/country_list.dart';
import 'package:visachecker/common/models/visa.dart';

import 'package:visachecker/common/utils/constants.dart';

class RequestManager {
  RequestManager._privateConstructor();

  static final RequestManager _instance = RequestManager._privateConstructor();

  factory RequestManager() {
    return _instance;
  }

  String getEndpoint(String suffix) {
    return kUrl + suffix;
  }

  Future<CountryList> getCountryList() async {
    Uri uri = Uri.parse(getEndpoint("countryList"));

    var response = await http.get(uri);
    var parsedJson = json.decode(response.body);
    return CountryList.fromJson(parsedJson);
  }

  Future<CountryCategoryList> getCountryVisaResult(String countryCode) async {
    Uri uri = Uri.parse(getEndpoint("api/$countryCode"));

    var response = await http.get(uri);
    var parsedJson = json.decode(response.body);
    return CountryCategoryList.fromJson(parsedJson);
  }

  Future<VisaInfo> getVisaInfo(String passport, destination) async {
    Uri uri = Uri.parse(getEndpoint("api/$passport/$destination"));

    var response = await http.get(uri);
    var parsedJson = json.decode(response.body);
    return VisaInfo.fromJson(parsedJson);
  }
}
