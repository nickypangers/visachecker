class Country {
  String continentCode;
  String continentName;
  String countryName;
  int countryNumber;
  String threeLetterCountryCode;
  String twoLetterCountryCode;

  Country(
      {this.continentCode,
      this.continentName,
      this.countryName,
      this.countryNumber,
      this.threeLetterCountryCode,
      this.twoLetterCountryCode});

  Country.fromJson(Map<String, dynamic> json) {
    continentCode = json['Continent_Code'];
    continentName = json['Continent_Name'];
    countryName = json['Country_Name'];
    countryNumber = json['Country_Number'];
    threeLetterCountryCode = json['Three_Letter_Country_Code'];
    twoLetterCountryCode = json['Two_Letter_Country_Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Continent_Code'] = this.continentCode;
    data['Continent_Name'] = this.continentName;
    data['Country_Name'] = this.countryName;
    data['Country_Number'] = this.countryNumber;
    data['Three_Letter_Country_Code'] = this.threeLetterCountryCode;
    data['Two_Letter_Country_Code'] = this.twoLetterCountryCode;
    return data;
  }
}
