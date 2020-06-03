import 'package:flutter/material.dart';
import 'main.dart';
import 'search.dart';
import 'settings.dart';

Widget drawer (BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 90,
          child: DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Visa Checker",
                    style: TextStyle(
                      fontSize: 17,
                      //fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              )),
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            color: Colors.black,
          ),
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        HomeScreen()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.search,
            color: Colors.black,
          ),
          title: Text(
            "Explore",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        SearchScreen()));
          },
        ),
        ListTile(
          leading: Icon(Icons.location_on, color: Colors.black),
          title: Text(
            "Map",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.people, color: Colors.black),
          title: Text(
            "Friends",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.settings, color: Colors.black),
          title: Text(
            "Settings",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        SettingsScreen()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.info_outline,
            color: Colors.black,
          ),
          title: Text(
            "About this App",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationVersion: '0.0.1',
            );
          },
        ),
      ],
    ),
  );
}