import 'package:flutter/cupertino.dart';

class Friend {

  String name;
  String country;
  String result;
  Color color;

  Friend({this.name, this.country, this.result, this.color});

  Friend.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    result = json['result'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'country': country,
    'result': result,
    'color': color,
  };

}