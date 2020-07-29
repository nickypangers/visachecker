import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visachecker/settings.dart';

class CurrencyConverterAPIScreen extends StatefulWidget {
  @override
  _CurrencyConverterAPIScreenState createState() =>
      _CurrencyConverterAPIScreenState();
}

class _CurrencyConverterAPIScreenState
    extends State<CurrencyConverterAPIScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _apiController = TextEditingController();

  bool hasKey = false;

  Future<bool> checkHasKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var check = prefs.getBool("hasApiKey");
    (check != null) ? check = check : check = false;
    return check;
  }

  Future<void> setHasKey(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("hasApiKey", val);
  }

  @override
  void initState() {
    super.initState();
    checkHasKey().then((val) {
      setState(() {
        hasKey = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      setHasKey(hasKey);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsScreen()));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10), // center
                    child: Text(
                      "Currency Converter API",
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
            SwitchListTile(
              title: Text("Show Currency Converter in Search"),
              value: hasKey,
              onChanged: (val) {
                setState(() {
                  hasKey = val;
                  print(hasKey);
                  setHasKey(hasKey);
                });
              },
            ),
            hasKey
                ? Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: TextField(
                      autocorrect: false,
                      decoration: InputDecoration(labelText: 'API Key'),
                      controller: _apiController,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
