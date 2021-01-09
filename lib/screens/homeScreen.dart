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
    );
  }

  Widget buildHomeTopCard(context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: 340,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildTopMenuRow(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTopMenuRow(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildTopMenuRowButton(
          color: Colors.grey.withOpacity(0.5),
          icon: Icons.menu,
        ),
        buildTopMenuRowButton(
          icon: Icons.notifications,
        ),
      ],
    );
  }

  Widget buildMenuButton(context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.withOpacity(0.5),
      ),
      padding: EdgeInsets.all(10),
      child: Icon(
        Icons.menu,
        color: Colors.white,
      ),
    );
  }

  Widget buildTopMenuRowButton({
    Color color = Colors.transparent,
    IconData icon,
    Color iconColor = Colors.white,
    double padding = 10,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // color: Colors.grey.withOpacity(0.5),
        color: color,
      ),
      padding: EdgeInsets.all(padding),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
