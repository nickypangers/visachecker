class RestCountries {
  String capital;

  RestCountries.fromJson(Map<String, dynamic> json) {
    capital = json['capital'];
  }
}
