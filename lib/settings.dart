import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'selectCountry.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String passportCountry;

  Future<void> _getPassportCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      passportCountry = prefs.getString('countryName');
    });
  }

  @override
  void initState() {
    _getPassportCountry();
    _getCurrencyConverterAPIKey();
    super.initState();
  }

  Widget categoryTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15,
        top: 10,
        bottom: 3,
      ),
      child: Text(text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  String currencyConverterAPIKey = "333ba142825cb4323982";

  Future<void> _getCurrencyConverterAPIKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (currencyConverterAPIKey == null) {
      setState(() {
        currencyConverterAPIKey = prefs.getString('CurrencyConverterAPIKey');
      });
    } else {
      prefs.setString("CurrencyConverterAPIKey", currencyConverterAPIKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[100],
        ),
        child: drawer(context),
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
                  categoryTitle("General"),
                  ListTile(
                    title: Text('Language',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        )),
                    subtitle: Text('English'),
                    //trailing: Icon(Icons.navigate_next),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Passport Country',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        )),
                    subtitle: Text('$passportCountry'),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectCountryScreen())),
                  ),
                  categoryTitle("Features"),
                  ListTile(
                      title: Text("Currency Converter API Key"),
                      subtitle: Text("$currencyConverterAPIKey"),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
