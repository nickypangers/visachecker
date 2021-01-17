import 'package:flutter/material.dart';
import 'package:visa_checker/common/components/bottom_nav_bar.dart';
import 'package:visa_checker/common/components/home_header.dart';
import 'package:visa_checker/common/components/popular_locations.dart';

import 'onBoardingScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        iconList: [
          Icons.home,
          Icons.card_travel,
          Icons.navigation,
          Icons.person,
        ],
        pageList: [
          OnBoardingScreen(),
          OnBoardingScreen(),
          OnBoardingScreen(),
          OnBoardingScreen(),
        ],
        onChange: (val) {
          print(val);
        },
        defaultSelectedIndex: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: HomeHeader(
              minExtent: 90,
              maxExtent: 340,
            ),
          ),
          // NetworkingPageContent(),
          SliverFillRemaining(
            child: Container(
              child: PopularLocations(),
            ),
          ),
        ],
      ),
    );
  }
}
