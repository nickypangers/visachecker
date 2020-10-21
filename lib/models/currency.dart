class CurrencyRate {
  double rate;
  int status;

  CurrencyRate(String pair, Map<String, dynamic> json) {
    rate = json['$pair'];
    status = json['status'];
  }
}
