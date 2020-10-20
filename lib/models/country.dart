// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
  Country({
    this.latlng,
  });

  dynamic latlng;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        latlng: json["latlng"],
      );

  Map<String, dynamic> toJson() => {
        "latlng": List<dynamic>.from(latlng.map((x) => x)),
      };
}
