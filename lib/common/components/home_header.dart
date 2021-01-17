import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class HomeHeader implements SliverPersistentHeaderDelegate {
  HomeHeader({
    this.minExtent,
    @required this.maxExtent,
  });
  final double minExtent;
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(shrinkOffset);
    var size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
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
            child: Image.asset(
              'assets/app/topcardbackground.jpg',
              fit: BoxFit.cover,
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
                (shrinkOffset < 164)
                    ? buildSearchBar(
                        context,
                        radius: 30,
                      )
                    : Container(),
                (shrinkOffset < 57) ? buildHomeCircleRow(context) : Container(),
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
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: ClipRRect(
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

  Widget buildHomeCircleColumn(context,
      {Color color = Colors.white,
      double dimension = 50,
      int value = 100,
      @required String title}) {
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

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement showOnScreenConfiguration
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration =>
      null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  // TODO: implement vsync
  TickerProvider get vsync => null;
}
