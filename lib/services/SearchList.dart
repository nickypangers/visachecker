import 'package:flutter/material.dart';
import 'CountryList.dart';
import 'Key.dart';

class DataSearch extends SearchDelegate<String> {
  TextEditingController controller;

  DataSearch({Key key, @required this.controller});

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
    if (controller.text != null) {
      Navigator.pop(context);
    }
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = countries
        .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
          onTap: () {
            controller.text = suggestionList[index];
            Navigator.pop(context);
            FocusScope.of(context).requestFocus(FocusNode());
          },
          leading: SizedBox(
            width: 32,
            height: 32,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  "https://www.countryflags.io/${cList[suggestionList[index]]}/flat/64.png"),
            ),
          ),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )),
      itemCount: suggestionList.length,
    );
  }
}
