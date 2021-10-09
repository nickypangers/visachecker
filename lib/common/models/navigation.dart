import 'package:flutter/material.dart';
import 'package:visachecker/common/screens/filtered_list_screen.dart';
import 'package:visachecker/common/screens/home_screen.dart';
import 'package:visachecker/common/screens/list_screen.dart';
import 'package:visachecker/common/screens/map_screen.dart';
import 'package:visachecker/common/screens/search_screen.dart';
import 'package:visachecker/common/utils/constants.dart';

enum NavigationEvents {
  homePageClickedEvent,
  searchClickedEvent,
  mapClickedEvent,
  listClickedEvent,
  visaFreeListClickedEvent,
  visaOnArrivaListClickedEvent,
  visaRequiredListClickedEvent,
  covidBanListClickedEvent,
  noAdmissionListClickedEvent,
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
      case NavigationEvents.listClickedEvent:
        return ListScreen();
      case NavigationEvents.visaFreeListClickedEvent:
        return FilteredListScreen(category: kVisaFree);
      case NavigationEvents.visaOnArrivaListClickedEvent:
        return FilteredListScreen(category: kVisaOnArrival);
      case NavigationEvents.visaRequiredListClickedEvent:
        return FilteredListScreen(category: kVisaRequired);
      case NavigationEvents.covidBanListClickedEvent:
        return FilteredListScreen(category: kCovidBan);
      case NavigationEvents.noAdmissionListClickedEvent:
        return FilteredListScreen(category: kNoAdmission);
      case NavigationEvents.searchClickedEvent:
        return const SearchScreen();
      default:
        // return const HomeScreen();
        return const HomeScreen();
    }
  }
}
