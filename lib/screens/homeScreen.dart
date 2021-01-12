import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          child: Container(
            height: 340,
            width: size.width,
            color: Color(0xff6a7bc9),
            child: Image.network(
              'https://cdn.pixabay.com/photo/2014/05/02/23/46/bridge-336475_960_720.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              children: [
                buildTopMenuRow(context),
                buildSpacing(
                  context,
                  height: 40,
                ),
                buildSearchBar(
                  context,
                  radius: 30,
                ),
                buildHomeCircleRow(context),
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
          color: Colors.grey.withOpacity(0.4),
          icon: Icons.menu,
        ),
        // buildTopMenuRowButton(
        //   icon: Icons.notifications_outlined,
        // ),
        buildFlagCircle(context),
      ],
    );
  }

  Widget buildFlagCircle(context) {
    var dimension = 40.0;
    return Container(
      height: dimension,
      width: dimension,
      child: SvgPicture.network(
        'https://hatscripts.github.io/circle-flags/flags/european_union.svg',
        placeholderBuilder: (context) => CircularProgressIndicator(),
      ),
    );
  }

  Widget buildTopMenuRowButton({
    Color color = Colors.transparent,
    IconData icon,
    Color iconColor = Colors.white,
    double padding = 8,
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

  Widget buildSpacing(context, {double height = 0}) {
    return SizedBox(
      height: height,
    );
  }

  Widget buildSearchBar(
    context, {
    double radius = 10,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        color: Colors.white.withOpacity(0.7),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search Location',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildHomeCircleRow(context) {
    return Container(
      padding: EdgeInsets.only(
        top: 30,
        left: 10,
        right: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildHomeCircleColumn(
            context,
            color: Color(0xff40cbfb),
            title: 'Free',
          ),
          buildHomeCircleColumn(
            context,
            color: Color(0xfffeb05e),
            title: 'On Arrival',
          ),
          buildHomeCircleColumn(
            context,
            color: Color(0xffff6182),
            title: 'Required',
          ),
          buildHomeCircleColumn(
            context,
            color: Color(0xff9a76d6),
            title: 'Ban',
          ),
        ],
      ),
    );
  }

  Widget buildHomeCircleColumn(
    context, {
    Color color = Colors.white,
    double dimension = 50,
    int value = 100,
    @required String title,
  }) {
    return Column(
      children: [
        Container(
          width: dimension,
          height: dimension,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(dimension / 2)),
            color: color,
          ),
          child: Center(
            child: Text(
              "$value",
              textAlign: TextAlign.center,
              style: kHomeCircleTextStyle,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            title,
            style: kHomeCircleTitleTextStyle,
          ),
        ),
      ],
    );
  }
}
