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
  CountryCategoryList get getCountryCategoryList =>
      CountryCategoryList(vf: vf, voa: voa, vr: vr, cb: cb, na: na);

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
  String? passport;
  String? destination;
  String? dur;
  String? status;
  String? category;
  Error? error;

  VisaInfo(
      {this.passport,
      this.destination,
      this.dur,
      this.status,
      this.category,
      this.error});

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
