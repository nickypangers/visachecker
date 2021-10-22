import 'dart:convert';

import 'package:test/test.dart';
import 'package:visachecker/common/models/visa.dart';

void main() {
  group(
    "CountryCategory",
    () {
      test(".fromJson returns correct object", () {
        String jsonString = """{
    "data": [
      "AO",
      "BH",
      "BO",
      "BF",
      "CA",
      "KM",
      "CI",
      "GN",
      "GW",
      "JO",
      "KE",
      "LB",
      "MG",
      "MV",
      "MR",
      "MZ",
      "NG",
      "OM",
      "PW",
      "RW",
      "WS",
      "SC",
      "SO",
      "LK",
      "TL",
      "TG",
      "TO",
      "TV",
      "AE"
    ],
    "length": 29
  }""";

        CountryCategory countryCategory =
            CountryCategory.fromJson(jsonDecode(jsonString));

        expect(countryCategory.length, equals(29));
      });
    },
  );

  group("CountryCategoryList", () {
    test(".fromJson returns correct object", () {
      String jsonString =
          """{"Passport":"HK","VF":{"data":["AL","AD","AG","AM","AT","BS","BB","BY","BE","BZ","BJ","BA","BW","BR","BG","CV","CL","CO","HR","CU","CY","CZ","DK","DM","DO","EC","EG","EE","FJ","FI","FR","DE","GD","GY","HT","IS","IR","IE","IT","JP","KI","XK","LV","LS","LI","LT","LU","MO","MW","MT","MU","MX","MD","MC","MN","ME","MA","NA","NL","NI","NE","MK","NO","PS","PA","PE","PT","QA","RO","RU","KN","LC","SM","RS","SK","SI","ZA","ES","VC","SR","SE","CH","TZ","TH","TT","TN","TR","UG","UA","GB","UY","UZ","VA","VE","YE","ZM","ZW"],"length":97},"VOA":{"data":["AO","BH","BO","BF","CA","KM","CI","GN","GW","JO","KE","LB","MG","MV","MR","MZ","NG","OM","PW","RW","WS","SC","SO","LK","TL","TG","TO","TV","AE"],"length":29},"VR":{"data":["AF","DZ","BT","BI","CF","TD","CN","CG","CD","CR","DJ","SV","GQ","ER","SZ","ET","GA","GM","GE","GH","GT","HN","IQ","JM","KG","LR","LY","ML","NR","NP","KP","PK","PY","ST","SN","SL","SS","SD","SY","TJ","TM","US"],"length":42},"CB":{"data":["AR","AU","AZ","BD","BN","KH","CM","GR","HU","IN","ID","IL","KZ","KW","LA","MY","MH","FM","MM","NZ","PG","PH","PL","SA","SG","SB","KR","TW","VU","VN"],"length":30},"NA":{"data":null,"length":0},"last_updated":"Fri, 22 Oct 2021 21:07:05 GMT","error":{"status":false,"error":""}}""";

      CountryCategoryList countryCategoryList =
          CountryCategoryList.fromJson(jsonDecode(jsonString));

      expect(countryCategoryList, isNot(equals(null)));
    });
  });
}
