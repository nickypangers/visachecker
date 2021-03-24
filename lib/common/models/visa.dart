class VisaResult {
  String passport;
  String destination;
  String code;

  VisaResult({this.passport, this.destination, this.code});

  VisaResult.fromJson(Map<String, dynamic> json) {
    passport = json['Passport'];
    destination = json['Destination'];
    code = json["Code"];
  }
}
