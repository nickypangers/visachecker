import 'package:flutter/material.dart';
import 'package:visachecker/common/models/country.dart';

enum VisaStatus { visaFree, visaOnArrival, visaRequired }

class CountryCategory {
  late List<dynamic>? data;
  late int length;

  CountryCategory({required this.data, required this.length});

  CountryCategory.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    length = json['length'];
  }
}

class CountryCategoryList extends ChangeNotifier {
  CountryCategory? vf;
  CountryCategory? voa;
  CountryCategory? vr;
  CountryCategory? cb;
  CountryCategory? na;

  CountryCategoryList({this.vf, this.voa, this.vr, this.cb, this.na});

  CountryCategory get getcountryCategoryListVf => vf!;
  CountryCategory get getcountryCategoryListVoa => voa!;
  CountryCategory get getcountryCategoryListVr => vr!;
  CountryCategory get getcountryCategoryListCb => cb!;
  CountryCategory get getcountryCategoryListNa => na!;

  setCountryCategoryList(CountryCategoryList countryCategoryList) {
    vf = countryCategoryList.vf;
    voa = countryCategoryList.voa;
    vr = countryCategoryList.vr;
    cb = countryCategoryList.cb;
    na = countryCategoryList.na;
    notifyListeners();
  }

  CountryCategoryList.fromJson(Map<String, dynamic> json) {
    vf = json['VF'] != null ? CountryCategory.fromJson(json['VF']) : null;
    voa = json['VOA'] != null ? CountryCategory.fromJson(json['VOA']) : null;
    vr = json['VR'] != null ? CountryCategory.fromJson(json['VR']) : null;
    cb = json['CB'] != null ? CountryCategory.fromJson(json['CB']) : null;
    na = json['NA'] != null ? CountryCategory.fromJson(json['NA']) : null;
  }
}

class CountryVisaInfo extends ChangeNotifier {
  List<Country>? vf;
  List<Country>? voa;
  List<Country>? vr;
  List<Country>? cb;
  List<Country>? na;

  CountryVisaInfo({this.vf, this.voa, this.vr, this.cb, this.na});
}
