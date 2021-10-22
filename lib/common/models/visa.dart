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

  CountryCategory get getcountryCategoryListVf =>
      vf ?? CountryCategory(data: [], length: 0);
  CountryCategory get getcountryCategoryListVoa =>
      voa ?? CountryCategory(data: [], length: 0);
  CountryCategory get getcountryCategoryListVr =>
      vr ?? CountryCategory(data: [], length: 0);
  CountryCategory get getcountryCategoryListCb =>
      cb ?? CountryCategory(data: [], length: 0);
  CountryCategory get getcountryCategoryListNa =>
      na ?? CountryCategory(data: [], length: 0);
  CountryCategoryList get getCountryCategoryList =>
      CountryCategoryList(vf: vf, voa: voa, vr: vr, cb: cb, na: na);

  int get getCountryCategoryListVfLength => vf == null ? 0 : vf!.length;
  int get getCountryCategoryListVoaLength => voa == null ? 0 : voa!.length;
  int get getCountryCategoryListVrLength => vr == null ? 0 : vr!.length;
  int get getCountryCategoryListCbLength => cb == null ? 0 : cb!.length;
  int get getCountryCategoryListNaLength => na == null ? 0 : na!.length;

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

class VisaData extends ChangeNotifier {
  Map<String, Destinations>? data;

  VisaData({this.data});

  setData(VisaData visaData) {
    data = visaData.data;
    notifyListeners();
  }

  List<Destination> getData(String countryCode) {
    return data![countryCode]!.destinations!;
  }

  List<Destination> getFilteredList(String countryCode, category) {
    var fullList = getData(countryCode);
    return fullList.where((element) => element.category == category).toList();
  }

  VisaData.fromJson(Map<String, dynamic> json) {
    data = new Map<String, Destinations>();
    json['data'].forEach((key, value) {
      data![key] = Destinations.fromJson(value);
    });
  }
}

class Destinations {
  List<Destination>? destinations;

  Destinations({this.destinations});

  Iterable<Destination> filteredDestinations(String category) {
    return destinations!.where((element) => element.category == category);
  }

  Destinations.fromJson(Map<String, dynamic> json) {
    destinations = [];
    json['destination'].forEach((v) {
      destinations!.add(Destination.fromJson(v));
    });
  }
}

class Destination {
  String? code;
  String? category;
  String? dur;
  String? status;

  Destination({
    this.code,
    this.category,
    this.dur,
    this.status,
  });

  Destination.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    category = json['category'];
    dur = json['dur'];
    status = json['text'];
  }

  @override
  String toString() {
    return "code=$code category=$category dur=$dur status=$status";
  }
}

class VisaInfo {
  static String? passport;
  static String? destination;
  static String? dur;
  static String? status;
  static String? category;
  static Error? error;

  // VisaInfo(
  //     {this.passport,
  //     this.destination,
  //     this.dur,
  //     this.status,
  //     this.category,
  //     this.error});

  String get getStatus => status ?? "";
  String get getPassport => passport ?? "";
  String get getDestination => destination ?? "";
  String get getDur => dur ?? "";
  String get getCategory => category ?? "";

  VisaInfo.fromJson(Map<String, dynamic> json) {
    passport = json['passport'];
    destination = json['destination'];
    dur = json['dur'];
    status = json['status'];
    category = json['category'];
    error = Error.fromJson(json['error']);
  }

  @override
  String toString() {
    return "passport=$passport destination=$destination dur=$dur status=$status category=$category error=$error";
  }
}

class Error {
  bool? status;
  String? error;

  Error({this.status, this.error});

  Error.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
  }

  @override
  String toString() {
    return "status=$status error=$error";
  }
}
