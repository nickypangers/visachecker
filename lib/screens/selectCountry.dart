import 'package:flutter/material.dart';
import 'package:visachecker/services/Key.dart';
import 'settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCountryScreen extends StatefulWidget {
  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Select Country",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: cList.length,
                  itemBuilder: (context, index) {
                    String key = cList.keys.elementAt(index);
                    return ListTile(
                      title: Text("$key"),
                      onTap: () {
                        setPassPortCountry(key);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsScreen()));
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> setPassPortCountry(String country) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('countryName', country);
  prefs.setString('countryCode', cList[country]);
}
