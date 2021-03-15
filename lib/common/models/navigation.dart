import 'package:flutter/material.dart';

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
        return Center(
          child: Container(
            child: Text('Home'),
          ),
        );
        break;
      // case NavigationEvents.SearchClickedEvent:
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
