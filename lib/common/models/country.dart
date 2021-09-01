import 'package:flutter/material.dart';

class Country extends ChangeNotifier {
  String countryCode;
  String countryName;
  String region;
  String flagUrl;
  String capital;
  String photo;
  // String continent;

  Country({
    this.countryCode,
    this.countryName,
    this.region,
    this.flagUrl,
    this.capital,
    this.photo,
    // this.continent,
  });

  String get getCountryCode => countryCode;

  String get getCountryName => countryName;

  String get getRegion => region;

  String get getFlagUrl => flagUrl;

  String get getCapital => capital;

  String get getPhoto => photo;

  // String get getContinent => continent;

  setCountry(Country country) {
    countryCode = country.countryCode;
    countryName = country.countryName;
    flagUrl = country.flagUrl;
    region = country.region;
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

  Map<String, dynamic> toJson() {
    return {
      "ISO2": this.countryCode,
      "Country": this.countryName,
      "Capital": this.capital,
      "Photo": this.photo,
      "FlagUrl": this.flagUrl,
    };
  }

  String toString() =>
      "countryCode=$countryCode countryName=$countryName flagUrl=$flagUrl region=$region capital=$capital photo=$photo";
}

class CountryCodeList {
  List<dynamic> countryCodeList;

  CountryCodeList({this.countryCodeList});

  CountryCodeList.fromJson(Map<String, dynamic> json) {
    countryCodeList = json['countries'];
  }
}
