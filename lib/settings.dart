import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'search.dart';
import 'main.dart';
import 'selectCountry.dart';

class SettingsScreen extends StatefulWidget {

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String passportCountry;

  Future<void> _getPassportCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      passportCountry = prefs.getString('countryName');
    });
  }

  @override void initState() {
    super.initState();
    _getPassportCountry();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[100],
        ),
        child: Drawer(
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
                  "Search",
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
                  Navigator.pop(context);
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
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 30, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10), // center
                    child: Text(
                      "Settings",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        //fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 0,
                ),
                children: <Widget>[
                  ListTile(
                    title: Text('Language',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        )),
                    subtitle: Text('English'),
                    //trailing: Icon(Icons.navigate_next),
                    onTap: () {
                    },
                  ),
                  ListTile(
                    title: Text('Passport Country',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        )),
                    subtitle: Text('$passportCountry'),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectCountryScreen()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
