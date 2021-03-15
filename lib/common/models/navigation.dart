import 'package:flutter/material.dart';
import 'package:visa_checker/screens/homeScreen.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  SearchClickedEvent,
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
      default:
        return Center(
          child: Container(
            child: Text('Testing'),
          ),
        );
        break;
    }
  }
}
