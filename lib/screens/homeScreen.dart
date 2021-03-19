import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visa_checker/common/common_util.dart';
import 'package:visa_checker/common/components/recommended_card.dart';
import 'package:visa_checker/common/constants.dart';
import 'package:visa_checker/common/data/countryData.dart';
import 'package:visa_checker/common/models/country.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  PageController _pageController = PageController();

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
          // _buildLocationPin(context, currentCountry),
          SizedBox(
            height: 8,
          ),
          _buildTopRow(context),
          SizedBox(
            height: 0,
          ),
          _buildRecommendedList(
            context,
            countryList: [
              countryList[0],
              countryList[25],
              countryList[58],
              countryList[100],
              countryList[185],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopRow(context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildGreetings(context),
          _buildSearchIcon(context, onPressed: () {
            print("testing");
          }),
        ],
      ),
    );
  }

  Widget _buildSearchIcon(context, {Function onPressed}) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: TextButton(
        onPressed: onPressed,
        child: Icon(
          Icons.search,
          size: 32,
          color: Colors.grey,
        ),
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
              fontSize: 22,
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
      height: 110,
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
