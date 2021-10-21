import 'package:visachecker/common/models/country.dart';
import 'package:flutter/material.dart';

class Search extends ChangeNotifier {
  static Country? _passportCountry;
  static Country? _destinationCountry;

  Country? get passportCountry => _passportCountry;
  Country? get destinationCountry => _destinationCountry;

  void setPassportCountry(Country? country) {
    _passportCountry = country;
    notifyListeners();
  }

  void setDestinationCountry(Country? country) {
    _passportCountry = country;
    notifyListeners();
  }
}
