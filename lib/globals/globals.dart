import 'package:flutter/cupertino.dart';
import 'package:visa_checker/common/models/country.dart';

class CurrentCountry extends ChangeNotifier {
  Country _country;

  void setCountry(Country country) {
    _country = country;

    notifyListeners();
  }

  String get getCountryName => _country.countryName;
  String get getCountryCode => _country.countryCode;
  String get getFlagUrl => _country.flagUrl;
}
