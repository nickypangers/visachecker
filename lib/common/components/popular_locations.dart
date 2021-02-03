import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:visa_checker/common/data/countryData.dart';
import 'package:visa_checker/common/data/countryList.dart';
import 'package:visa_checker/common/models/country.dart';
import '../constants.dart';

import 'package:http/http.dart' as http;

class PopularLocations extends StatefulWidget {
  @override
  _PopularLocationsState createState() => _PopularLocationsState();
}

class _PopularLocationsState extends State<PopularLocations> {
  PageController _pageController;

  double yPadding = 20.0;

  List<String> _categoryList = [
    'Favorites',
    'Top 10',
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onTabPressed(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: yPadding),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  "Popular Locations",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Container(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categoryList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print('$index - ${_categoryList[index]}');
                        setState(() {
                          onTabPressed(index);
                          _selectedIndex = index;
                        });
                      },
                      child: Row(
                        children: [
                          buildCategoryTab(context,
                              category: _categoryList[index],
                              color: (index == _selectedIndex)
                                  ? kLocationSelectedColor
                                  : kLocationUnselectedColor),
                          (index != _categoryList.length - 1)
                              ? SizedBox(
                                  width: 20,
                                )
                              : Container()
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: buildPageView(),
        ),
      ],
    );
  }

  Widget buildCategoryTab(context, {String category, Color color}) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Text(
        category,
        style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color),
      ),
    );
  }

  Widget buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (val) {
        setState(() {
          _selectedIndex = val;
        });
        print(_selectedIndex);
      },
      children: [
        buildPage(allList, color: Colors.red), // All Worlds
        buildPage(afList, color: Colors.yellow), // Africa
        // buildPage(asList, color: Colors.green), // Asia
        // buildPage(euList, color: Colors.blue), // Europe
        // buildPage(naList, color: Colors.grey), // North America
        // buildPage(saList, color: Colors.orange), // South America
        // buildPage(ocList, color: Colors.purple), // Oceania
      ],
    );
  }

  Widget buildPage(List<Country> dataList, {Color color}) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return Container(
              color: color,
              child: Text(
                  "$index - ${dataList[index].countryName} - ${dataList[index].threeLetterCountryCode}"),
            );
          },
        ),
      ),
    );
  }
}
