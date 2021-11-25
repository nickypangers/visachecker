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
    switch (kEnvironment) {
      case Environment.production:
        return 'https://passportvisa-api.herokuapp.com/$suffix';
      case Environment.development:
        return 'https://passport-visa-api.herokuapp.com/$suffix';
      case Environment.local:
        return 'http://192.168.50.79:3001/$suffix';
    }

    // return kUrl + suffix;
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

  Future<VisaData> getVisaData() async {
    Uri uri = Uri.parse(getEndpoint("raw"));

    var response = await http.get(uri);
    var parsedJson = json.decode(response.body);
    return VisaData.fromJson(parsedJson);
  }

  Future<String> getLatestAppVersion() async {
    Uri uri = Uri.parse(getEndpoint("appversion"));

    var response = await http.get(uri);
    var parsedJson = json.decode(response.body);
    return parsedJson['app_version'];
  }
}
