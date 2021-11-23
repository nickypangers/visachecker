import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visachecker/common/models/visa.dart';
import 'package:visachecker/manager/request_manager.dart';

class Country extends ChangeNotifier {
  String? name;
  String? code;

  Country({this.name, this.code});

  String? get getCountryName => name;
  String? get getCountryCode => code;

  Country get getCountry => Country(name: name, code: code);

  String toString() {
    return "name:$name code:$code";
  }

  setCountry(BuildContext context, Country country) async {
    name = country.name;
    code = country.code;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool status = await preferences.setString("country", code!);
    if (!status) {
      debugPrint("unable to save country on set.");
    }

    CountryCategoryList countryCategoryList =
        await RequestManager().getCountryVisaResult(code!);

    Provider.of<CountryCategoryList>(context, listen: false)
        .setCountryCategoryList(countryCategoryList);

    notifyListeners();
  }

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }
}
