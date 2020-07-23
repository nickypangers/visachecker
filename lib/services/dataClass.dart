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
  String vr;
  String voa;
  String vf;

  Country(Map<String, dynamic> json) {
    vr = json['VR'];
    voa = json['VOA'];
    vf = json['VF'];
  }
}

class CountryList {
  List<dynamic> vr;
  List<dynamic> voa;
  List<dynamic> vf;

  CountryList(Map<String, dynamic> json) {
    vr = json['VR'];
    voa = json['VOA'];
    vf = json['VF'];
  }
}
