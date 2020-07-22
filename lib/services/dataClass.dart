class Visa {
  String passport;
  String destination;
  String code;

  Visa(Map<String, dynamic> json) {
    passport = json['Passport'];
    destination = json['Destination'];
    code = json['Code'];
  }
}

class Country {
  String VR;
  String VOA;
  String VF;

  Country(Map<String, dynamic> json) {
    VR = json['VR'];
    VOA = json['VOA'];
    VF = json['VF'];
  }
}

class CountryList {
  List<dynamic> VR;
  List<dynamic> VOA;
  List<dynamic> VF;

  CountryList(Map<String, dynamic> json) {
    VR = json['VR'];
    VOA = json['VOA'];
    VF = json['VF'];
  }
}
