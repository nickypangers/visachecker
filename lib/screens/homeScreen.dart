import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visa_checker/common/common_util.dart';
import 'package:visa_checker/common/components/recommended_card.dart';
import 'package:visa_checker/common/models/country.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  PageController _pageController = PageController();

  List<Country> countryList = [
    Country(countryCode: 'HK', countryName: 'Hong Kong', flagUrl: '#'),
    Country(countryCode: 'HK', countryName: 'Hong Kong', flagUrl: '#'),
    Country(countryCode: 'HK', countryName: 'Hong Kong', flagUrl: '#'),
    Country(countryCode: 'HK', countryName: 'Hong Kong', flagUrl: '#'),
    Country(countryCode: 'HK', countryName: 'Hong Kong', flagUrl: '#'),
  ];

  String _getCurrentTime() {
    var now = DateTime.now();

    return DateFormat('kk').format(now);
  }

  String _getGreetings(String hourString) {
    int hour = stringToInt(hourString);

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    }
    if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    }
    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<Country>(
      builder: (context, currentCountry, child) => Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildLocationPin(context, currentCountry),
          _buildGreetings(context),
          SizedBox(
            height: 25,
          ),
          _buildRecommendedList(
            context,
            countryList: countryList,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedList(context,
      {height = 150.0, List<Country> countryList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Recommended',
            style: TextStyle(
              fontSize: 26,
            ),
          ),
        ),
        Container(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: countryList.length,
            itemBuilder: (context, index) => RecommendedCard(
              country: countryList[index],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreetings(context) {
    var currentTime = _getCurrentTime();
    return Container(
      padding: EdgeInsets.only(left: 45.0),
      height: 47,
      child: Row(
        children: [
          Text(
            "${_getGreetings(currentTime)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLocationPin(context, currentCountry) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        // padding: EdgeInsets.only(left: 10),
        child: IntrinsicWidth(
          child: Row(
            children: [
              Icon(Icons.pin_drop_outlined),
              Text(
                currentCountry.getCountryName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
