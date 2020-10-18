import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visa_checker/info/info.dart';
import 'package:visa_checker/services/functions.dart';
import 'package:visa_checker/services/prefs.dart';
import '../settings.dart';

class CurrencyConverterAPIScreen extends StatefulWidget {
  @override
  _CurrencyConverterAPIScreenState createState() =>
      _CurrencyConverterAPIScreenState();
}

class _CurrencyConverterAPIScreenState
    extends State<CurrencyConverterAPIScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _apiController = TextEditingController();

  bool _hasKey = false;

  Future<bool> checkHasKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var check = prefs.getBool(showCurrencyKey);
    (check != null) ? check = check : check = false;
    return check;
  }

  @override
  void initState() {
    super.initState();
    getAPIKey(currencyKey).then((val) {
      if (val != null) {
        _apiController..text = val;
      }
    });
    checkHasKey().then((val) {
      setState(() {
        _hasKey = val;
      });
    });
  }

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
                    onPressed: () {
                      print(_apiController.text);
                      setState(() {
                        if (_apiController.text.isEmpty) {
                          _hasKey = false;
                        }
                      });
                      setHasKey(showCurrencyKey, _hasKey);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsScreen()));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Currency Converter API",
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
            SwitchListTile(
              title: Text("Show Currency Converter in Search"),
              value: _hasKey,
              onChanged: (val) {
                setState(() {
                  _hasKey = val;
                  print(_hasKey);
                  setHasKey(showCurrencyKey, _hasKey);
                });
              },
            ),
            _hasKey
                ? Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: Container(
                      child: TextField(
                        autocorrect: false,
                        decoration: InputDecoration(labelText: 'API Key'),
                        controller: _apiController,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        onSubmitted: (val) {
                          print(val);
                          if (val.isNotEmpty) {
                            setAPIKey(currencyKey, val);
                          } else {
                            setState(() => _hasKey = false);
                          }
                        },
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Text("""
              In order to show the currency rate, you will need to have an API Key from currencyconverterapi.com (not associated).\n
              If you do not have an account, please register a free account in order to retreive your API key and paste it into the text field above.
              """),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Container(
                child: Center(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                      side: BorderSide(color: Colors.black, width: 2),
                    ),
                    child: Text("Get API Key"),
                    onPressed: () =>
                        openBrowserTab("https://www.currencyconverterapi.com/"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
