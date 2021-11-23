import 'package:flutter/material.dart';
import 'package:visachecker/common/models/country.dart';

class CountryList extends ChangeNotifier {
  List<Country>? list;

  CountryList({this.list});

  List<Country>? get getCountryList => list;

  setCountryList(CountryList countryList) {
    list = countryList.list;
    notifyListeners();
  }

  Country getCountryByCode(String code) {
    return list!.firstWhere(
      (country) => country.getCountryCode == code,
    );
  }

  CountryList.fromJson(Map<String, dynamic> json) {
    list = List<Country>.from(
        json['list'].map((country) => Country.fromJson(country)));
  }
}
