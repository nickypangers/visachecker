import 'package:flutter/material.dart';
import 'package:visa_checker/common/components/bottom_nav_bar.dart';
import 'package:visa_checker/common/constants.dart';
import 'package:visa_checker/common/tranisitons/reveal_route.dart';
import 'package:visa_checker/screens/onBoardingScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: kBackgroundColor,
        child: Column(
          children: [
            buildHomeTopCard(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        iconList: [
          Icons.home,
          Icons.card_travel,
          Icons.navigation,
          Icons.person,
        ],
        onChange: (val) {
          if (val < 3) {
            Navigator.pushReplacement(
                context,
                RevealRoute(
                  maxRadius: 800,
                  page: OnBoardingScreen(),
                  centerAlignment: Alignment.center,
                ));
          }
        },
        defaultSelectedIndex: 0,
      ),
    );
  }

  Widget buildHomeTopCard(context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.45,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
    );
  }
}
