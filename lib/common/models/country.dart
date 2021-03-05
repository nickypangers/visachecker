// class Country {
//   String continentCode;
//   String continentName;
//   String countryName;
//   int countryNumber;
//   String threeLetterCountryCode;
//   String twoLetterCountryCode;

//   Country(
//       {this.continentCode,
//       this.continentName,
//       this.countryName,
//       this.countryNumber,
//       this.threeLetterCountryCode,
//       this.twoLetterCountryCode});

//   Country.fromJson(Map<String, dynamic> json) {
//     continentCode = json['Continent_Code'];
//     continentName = json['Continent_Name'];
//     countryName = json['Country_Name'];
//     countryNumber = json['Country_Number'];
//     threeLetterCountryCode = json['Three_Letter_Country_Code'];
//     twoLetterCountryCode = json['Two_Letter_Country_Code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Continent_Code'] = this.continentCode;
//     data['Continent_Name'] = this.continentName;
//     data['Country_Name'] = this.countryName;
//     data['Country_Number'] = this.countryNumber;
//     data['Three_Letter_Country_Code'] = this.threeLetterCountryCode;
//     data['Two_Letter_Country_Code'] = this.twoLetterCountryCode;
//     return data;
//   }
// };

import 'package:flutter/material.dart';

class Country extends ChangeNotifier {
  String countryCode;
  String countryName;
  String flagUrl;

  Country({this.countryCode, this.countryName, this.flagUrl});

  String get getCountryCode => countryCode;

  String get getCountryName => countryName;

  String get getFlagUrl => flagUrl;

  setCountry(Country country) {
    countryCode = country.countryCode;
    countryName = country.countryName;
    flagUrl = country.flagUrl;

    notifyListeners();
  }

  Country.fromJson(Map<String, dynamic> json) {
    countryCode = json['Code'];
    countryName = json['Name'];
    flagUrl = "assets/flags/${countryCode.toLowerCase()}.svg";
  }
}

class CountryCodeList {
  List<dynamic> countryCodeList;

  CountryCodeList({this.countryCodeList});

  CountryCodeList.fromJson(Map<String, dynamic> json) {
    countryCodeList = json['countries'];
  }
}
