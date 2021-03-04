import 'package:flutter/material.dart';
import 'package:visa_checker/common/components/search/search_result_tile.dart';
import 'package:visa_checker/common/data/countryData.dart';
import 'package:visa_checker/common/models/country.dart';

class Search extends SearchDelegate<Country> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = countryList
        .where((p) => p.countryName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).pop(suggestionList[index]);
        },
        child: SearchResultTile(country: suggestionList[index]),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = countryList
        .where((p) => p.countryName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).pop(suggestionList[index]);
        },
        child: SearchResultTile(country: suggestionList[index]),
      ),
    );
  }
}
