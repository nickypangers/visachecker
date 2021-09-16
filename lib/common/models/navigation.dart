import 'package:flutter/material.dart';
import 'package:visachecker/common/screens/home_screen.dart';
import 'package:visachecker/common/screens/map_screen.dart';

enum NavigationEvents {
  homePageClickedEvent,
  searchClickedEvent,
  mapClickedEvent
}

class NavigationState extends ChangeNotifier {
  late NavigationEvents currentNavigationEvent;

  setNavigation(NavigationEvents state) {
    currentNavigationEvent = state;
    notifyListeners();
  }

  Widget getCurrentNavigation() {
    switch (currentNavigationEvent) {
      case NavigationEvents.homePageClickedEvent:
        return const HomeScreen();
      // case NavigationEvents.MapClickedEvent:
      default:
        return const MapScreen();
    }
  }
}
