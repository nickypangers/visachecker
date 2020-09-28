class Capital {
  String capital;
  String country;

  Capital(Map<String, dynamic> json) {
    capital = json['$country'];
  }
}
