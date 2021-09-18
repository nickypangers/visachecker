import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visachecker/common/models/visa.dart';
import 'package:visachecker/common/screens/home_screen.dart';
import 'package:visachecker/common/screens/list_screen.dart';
import 'package:visachecker/common/screens/map_screen.dart';

enum NavigationEvents {
  homePageClickedEvent,
  searchClickedEvent,
  mapClickedEvent,
  listClickedEvent
}

class NavigationState extends ChangeNotifier {
  late NavigationEvents currentNavigationEvent;

  setNavigation(NavigationEvents state) {
    currentNavigationEvent = state;
    notifyListeners();
  }

  Widget getCurrentNavigation(BuildContext context) {
    switch (currentNavigationEvent) {
      case NavigationEvents.homePageClickedEvent:
        return const HomeScreen();
      case NavigationEvents.mapClickedEvent:
        return const MapScreen();
      default:
        // return const HomeScreen();
        return ListScreen(
            countryCategory: Provider.of<CountryCategoryList>(context)
                .getcountryCategoryListVf);
    }
  }
}
