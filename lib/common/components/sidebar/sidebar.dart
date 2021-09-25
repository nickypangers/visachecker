import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visachecker/common/components/search/search.dart';
import 'package:visachecker/common/components/sidebar/menu_item.dart';
import 'package:visachecker/common/models/country.dart';
import 'package:visachecker/common/models/navigation.dart';
import 'package:visachecker/common/utils/constants.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  late AnimationController _animationController;
  late StreamController<bool> isSidebarOpenedStreamController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamSink<bool> isSidebarOpenedSink;
  // final bool isSidebarOpened = false;
  final _animationDuration = const Duration(milliseconds: 500);

  // final double _tabWidth = 35.0;

  // int index = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  void onSwipeRight() {
    isSidebarOpenedSink.add(true);
    _animationController.forward();
  }

  void onSwipeLeft() {
    isSidebarOpenedSink.add(false);
    _animationController.reverse();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    var dimension = 50.0;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data! ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data!
              ? 0
              : screenWidth - (kTabWidth + kSidebarMargin),
          child: GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dx > 10) {
                debugPrint("swipe open sidebar");
                onSwipeRight();
                return;
              }
              if (details.delta.dx < -10) {
                debugPrint("swipe close sidebar");
                onSwipeLeft();
              }
            },
            child: Row(
              children: [
                Consumer<Country>(
                  builder: (context, currentCountry, child) => Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(right: 10.0),
                      color: kIconBackgroundColor,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          GestureDetector(
                            onTap: () async {
                              var result = await showSearch(
                                context: context,
                                delegate: Search(),
                              );

                              if (result == null) {
                                return;
                              }
                              currentCountry.setCountry(context, result);
                              // setSelectedCountry(result);
                              // CountryCategoryList countryCategoryList =
                              //     await getVisaListResult(result);
                              // Provider.of<VisaList>(context, listen: false)
                              //     .setVisaList(visaListResult);
                              // print(currentCountry.getCountryName);
                              // onIconPressed();
                            },
                            child: ListTile(
                              title: Text(
                                "${currentCountry.getCountryName}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              subtitle: const Text(
                                'Tap to change country',
                                style: TextStyle(
                                  color: Color(0xfff3fcf4),
                                  fontSize: 14,
                                ),
                              ),
                              leading: SizedBox(
                                height: dimension,
                                width: dimension,
                                child: SvgPicture.asset(
                                    "assets/flags/${currentCountry.getCountryCode!.toLowerCase()}.svg"),
                              ),
                            ),
                          ),
                          MenuItem(
                            icon: Icons.home,
                            title: 'Home',
                            clickedEvent: NavigationEvents.homePageClickedEvent,
                            onPressed: () => onIconPressed(),
                          ),
                          // MenuItem(
                          //   icon: Icons.map,
                          //   title: 'Map',
                          //   clickedEvent: NavigationEvents.mapClickedEvent,
                          //   onPressed: () => onIconPressed(),
                          // ),
                          MenuItem(
                            icon: Icons.list,
                            title: 'All Countries',
                            clickedEvent: NavigationEvents.listClickedEvent,
                            onPressed: () => onIconPressed(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0, -0.9),
                  child: GestureDetector(
                    onTap: () {
                      onIconPressed();
                    },
                    child: ClipPath(
                      clipper: CustomMenuClipper(),
                      child: Container(
                        width: kTabWidth,
                        height: 110,
                        color: kIconBackgroundColor,
                        alignment: Alignment.centerLeft,
                        child: AnimatedIcon(
                          progress: _animationController.view,
                          icon: AnimatedIcons.menu_close,
                          color: kBackgroundColor,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
