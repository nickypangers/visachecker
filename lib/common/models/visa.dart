import 'package:flutter/material.dart';
import 'package:visa_checker/common/methods/visa.dart';
import 'package:visa_checker/common/models/country.dart';

enum VisaStatus { visaFree, visaOnArrival, visaRequired }

class VisaResult {
  String passport;
  String destination;
  String code;

  VisaResult({this.passport, this.destination, this.code});

  VisaResult.fromJson(Map<String, dynamic> json) {
    passport = json['Passport'];
    destination = json['Destination'];
    code = json["Code"];
  }
}

class VisaListResult {
  List<dynamic> vf;
  List<dynamic> voa;
  List<dynamic> vr;
  List<dynamic> cb;
  List<dynamic> na;

  VisaListResult({this.vf, this.voa, this.vr});

  VisaListResult.fromJson(Map<String, dynamic> json) {
    vf = json['VF'];
    voa = json['VOA'];
    vr = json["VR"];
    cb = json["CB"];
    na = json["NA"];
  }
}

class VisaList extends ChangeNotifier {
  List<Country> vf;
  List<Country> voa;
  List<Country> vr;
  List<Country> cb;
  List<Country> na;

  VisaList({this.vf, this.voa, this.vr});

  setVisaList(VisaListResult visaListResult) {
    vf = [];
    voa = [];
    vr = [];
    cb = [];
    na = [];
    visaListResult.vf.forEach((countryCode) {
      // print('vf: $countryCode');
      var country = getCountryFromCode(countryCode);
      vf.add(country);
      // print('$country');
    });
    visaListResult.voa.forEach((countryCode) {
      // print('voa: $countryCode');
      var country = getCountryFromCode(countryCode);
      voa.add(country);
      // print('$country');
    });
    visaListResult.vr.forEach((countryCode) {
      // print('vr: $countryCode');
      var country = getCountryFromCode(countryCode);
      vr.add(country);
      // print('$country');
    });
    visaListResult.cb.forEach((countryCode) {
      // print('cb: $countryCode');
      var country = getCountryFromCode(countryCode);
      cb.add(country);
      // print('$country');
    });
    visaListResult.na.forEach((countryCode) {
      // print('na: $countryCode');
      var country = getCountryFromCode(countryCode);
      na.add(country);
      // print('$country');
    });
    notifyListeners();
  }
}
