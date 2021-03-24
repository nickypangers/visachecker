import 'package:flutter/material.dart';

class Country extends ChangeNotifier {
  String countryCode;
  String countryName;
  String flagUrl;
  String capital;
  String photo;

  Country({this.countryCode, this.countryName, this.flagUrl});

  String get getCountryCode => countryCode;

  String get getCountryName => countryName;

  String get getFlagUrl => flagUrl;

  String get getCapital => capital;

  String get getPhoto => photo;

  setCountry(Country country) {
    countryCode = country.countryCode;
    countryName = country.countryName;
    flagUrl = country.flagUrl;
    capital = country.capital;
    photo = country.photo;

    notifyListeners();
  }

  Country.fromJson(Map<String, dynamic> json) {
    countryCode = json['ISO2'];
    countryName = json['Country'];
    flagUrl = "assets/flags/${countryCode.toLowerCase()}.svg";
    capital = json['Capital'];
    photo = json['Photo'];
  }
}

class CountryCodeList {
  List<dynamic> countryCodeList;

  CountryCodeList({this.countryCodeList});

  CountryCodeList.fromJson(Map<String, dynamic> json) {
    countryCodeList = json['countries'];
  }
}
