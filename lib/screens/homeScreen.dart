import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visa_checker/common/methods/visa.dart';
import 'package:visa_checker/common/common_util.dart';
import 'package:visa_checker/common/components/recommended_card.dart';
import 'package:visa_checker/common/constants.dart';
import 'package:visa_checker/common/data/countryData.dart';
import 'package:visa_checker/common/models/country.dart';
import 'package:intl/intl.dart';
import 'package:visa_checker/common/models/visa.dart';

class HomeScreen extends StatelessWidget {
  // PageController _pageController = PageController();

  List<Country> list = [
    countryList[0],
    countryList[10],
    countryList[50],
    countryList[100],
    countryList[150],
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
    var visaList = Provider.of<VisaList>(context);
    // print('vf ${visaList.vf.length} ${visaList.vf[0].toString()}');
    return Consumer<Country>(
      builder: (context, currentCountry, child) => Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // _buildLocationPin(context, currentCountry),
          // SizedBox(
          //   height: 8,
          // ),
          _buildGreetings(context),
          _buildRecommendedList(
            context,
            list: [
              visaList.vf[0],
              visaList.vf[1],
              visaList.vf[2],
              visaList.vf[3],
              visaList.vf[4],
            ],
          ),
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

  Widget _buildRecommendedList(context, {height = 150.0, List<Country> list}) {
    print(list.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryHeader(context, title: 'Visa-Free Ideas', onClick: () {
          print('hi');
        }),
        Container(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) => RecommendedCard(
              country: list[index],
              visa: "Visa Free",
            ),
          ),
        ),
      ],
    );
  }

  Padding _buildCategoryHeader(context, {String title, Function onClick}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$title',
            style: TextStyle(
              fontSize: 26,
            ),
          ),
          GestureDetector(
            onTap: onClick,
            child: Text(
              'View More',
              style: kViewMoreTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreetings(context) {
    var currentTime = _getCurrentTime();
    return Container(
      padding: EdgeInsets.only(left: 45.0),
      height: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${_getGreetings(currentTime)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 34,
              ),
              onPressed: () {
                print('hi');
              }),
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
