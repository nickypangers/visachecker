import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:visa_checker/common/constants.dart';
import 'package:visa_checker/common/data/countryData.dart';
import 'package:visa_checker/common/data/countryList.dart';
import 'package:visa_checker/common/models/country.dart';

import 'onBoardingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // getAllCountryList().then((_) {
    //   var totalCountries = afList.length +
    //       asList.length +
    //       euList.length +
    //       naList.length +
    //       saList.length +
    //       ocList.length;
    //   print(totalCountries);
    // });
  }

  Future<bool> getAllCountryList() async {
    // afList = await getCountryList('Africa');
    // asList = await getCountryList('Asia');
    // euList = await getCountryList('Europe');
    // naList = await getCountryList('North America');
    // saList = await getCountryList('South America');
    // ocList = await getCountryList('Oceania');

    // allList = [
    //   ...afList,
    //   ...asList,
    //   ...euList,
    //   ...naList,
    //   ...saList,
    //   ...ocList
    // ];
    // print(allList.length);

    var countries = await getCountries();

    print(countries.runtimeType);

    countryList = await getCountryList(countries);

    print(countryList.length);

    return true;
  }

  Future<List<Country>> getCountryList(List<dynamic> countries) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/countries.json");

    var parsedJson = json.decode(data);

    // print(parsedJson.toString());

    List<Country> list = [];

    parsedJson.forEach((item) {
      Country country = Country.fromJson(item);

      countries.forEach((countryCode) {
        if (countryCode == country.countryCode) {
          list.add(country);
        }
      });
    });

    print(list[0].countryCode);

    return list;
  }

  Future<List<dynamic>> getCountries() async {
    // var url =
    //     "https://pkgstore.datahub.io/JohnSnowLabs/country-and-continent-codes-list/country-and-continent-codes-list-csv_json/data/c218eebbf2f8545f3db9051ac893d69c/country-and-continent-codes-list-csv_json.json";

    // var response = await http.get(url);

    // var parsedJson = json.decode(response.body);

    // print(parsedJson.runtimeType);

    // List<Country> data = [];

    // parsedJson.forEach((item) {
    //   Country country = Country.fromJson(item);

    //   if (country.continentName == continent) {
    //     countryList.forEach((k, v) {
    //       if (k == country.twoLetterCountryCode) {
    //         country.countryName = v;
    //         print(
    //             "Country: ${country.countryName} - ${country.twoLetterCountryCode}");
    //         data.add(country);
    //       }
    //     });
    //   }
    // });

    var url = "http://passportvisa-api.herokuapp.com/list/countries";

    var response = await http.get(url);

    var parsedJson = json.decode(response.body);

    CountryCodeList list = CountryCodeList.fromJson(parsedJson);

    // print(list.countryCodeList.toString());

    return list.countryCodeList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllCountryList(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            Timer(
                Duration(seconds: 3),
                () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OnBoardingScreen())));
          }
          return Container(
            color: kIconBackgroundColor,
            child: Center(
              child: SpinKitChasingDots(
                color: Colors.white,
              ),
            ),
          );
        });
  }
}
