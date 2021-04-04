import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visa_checker/common/components/continent_button.dart';
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
        children: _buildMain(context, visaList),
      ),
    );
  }

  List<Widget> _buildMain(BuildContext context, VisaList visaList) {
    return [
      _buildGreetings(context),
      _buildRecommendedList(
        context,
        list: _getVisaFreeIdeaList(visaList.vf),
      ),
      _buildContinentSection(context),
    ];
  }

  Widget _buildContinentSection(context) {
    return Column(
      children: [
        _buildCategoryHeader(context, title: 'By Continent'),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ContinentButton(continent: Continent.asia, color: Colors.yellow),
            ContinentButton(continent: Continent.africa, color: Colors.orange),
            ContinentButton(continent: Continent.europe, color: Colors.blue),
            ContinentButton(continent: Continent.oceania, color: Colors.red),
            ContinentButton(
                continent: Continent.southAmerica, color: Colors.purple),
            ContinentButton(
                continent: Continent.northAmerica, color: Colors.green),
          ],
        ),
      ],
    );
  }

  List<Country> _getVisaFreeIdeaList(List<Country> dataList) {
    List<Country> list = [];

    var limit = (dataList.length > 5) ? 5 : dataList.length;

    for (var i = 0; i < limit; i++) {
      list.add(dataList[i]);
    }

    return list;
  }

  Widget _buildRecommendedList(context, {height = 150.0, List<Country> list}) {
    // print(list.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryHeader(context,
            title: 'Visa-Free Ideas', showViewMore: true, onClick: () {
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

  Padding _buildCategoryHeader(context,
      {String title, bool showViewMore = false, Function onClick}) {
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
          showViewMore
              ? GestureDetector(
                  onTap: onClick,
                  child: Text(
                    'View More',
                    style: kViewMoreTextStyle,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildGreetings(context) {
    var currentTime = _getCurrentTime();
    return Container(
      padding: EdgeInsets.only(left: 45.0),
      alignment: Alignment.centerLeft,
      height: 110,
      child: Text(
        "${_getGreetings(currentTime)}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
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
