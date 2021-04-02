import 'package:flutter/material.dart';
import 'package:visa_checker/screens/homeScreen.dart';
import 'package:visa_checker/screens/mapScreen.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  SearchClickedEvent,
  MapClickedEvent
}

class NavigationState extends ChangeNotifier {
  NavigationEvents currentNavigationEvent;

  setNavigation(NavigationEvents state) {
    currentNavigationEvent = state;
    notifyListeners();
  }

  Widget getCurrentNavigation() {
    switch (currentNavigationEvent) {
      case NavigationEvents.HomePageClickedEvent:
        return HomeScreen();
        break;
      // case NavigationEvents.MapClickedEvent:
      default:
        return MapScreen();
        break;
    }
  }
}
