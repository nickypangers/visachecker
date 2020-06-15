import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visachecker/services/dataClass.dart';
import 'drawer.dart';
import 'search.dart';
import 'settings.dart';
import 'services/Key.dart';
import 'services/SearchList.dart';
import 'services/CountryData.dart';
import 'splash.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      // initialRoute: '/splash',
      // routes: {
      //   '/splash': (context) => IntroScreen(),
      //   '/': (context) => HomeScreen(),
      //   '/search': (context) => SearchScreen(),
      //   '/settings': (context) => SettingsScreen(),
      // },
      home: SplashScreen(),
    ));

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String visa_free = "";
  String visa_on_arrival = "";
  String visa_required = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _controller = TextEditingController();

  String cCode, cName;

  Future passportBuilder;

  @override
  initState() {
    super.initState();
    passportBuilder = _passportCountry();
    print("Name: $cName");
    print("Code: $cCode");
  }

 _passportCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = prefs.getBool('seen');
    print("seen: $_seen");
    String countryName = prefs.getString('countryName');
    setState(() {
      cName = countryName;
      cCode = cList[cName];
      print("prefs name: $cName");
      print("prefs code: $cCode");
      fetchCountry().then((value) {
        Country data = value;
        setState(() {
          visa_free = data.VF;
          visa_on_arrival = data.VOA;
          visa_required = data.VR;
        });
      });    
    });
  }

  Future<Country> fetchCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String countryCode = prefs.getString('countryCode');
    var url = "https://passportvisa-api.herokuapp.com/api/$cCode";
    var response = await http.get(url);
    var parsedJson = json.decode(response.body);
    print(parsedJson);
    var country = Country(parsedJson);
    return country;
  }

  _setDesCountry(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('desCountry', value);
  }

  openBrowserTab(String url) async {
    await FlutterWebBrowser.openWebPage(
        url: url, androidToolbarColor: Colors.white);
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
        body: FutureBuilder(
          future: passportBuilder,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: <Widget>[
                  Container(
                    child: Padding(
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
                              "Visa Checker",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                //fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            right: 25,
                            left: 25,
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(20.0),
                                    topRight: const Radius.circular(20.0),
                                    bottomLeft: const Radius.circular(20.0),
                                    bottomRight: const Radius.circular(20.0),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 255,
                                          child: TextField(
                                            style: TextStyle(
                                                color: Colors.grey[700]),
                                            cursorColor: Colors.grey[700],
                                            controller: _controller,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              hintText: 'Enter destination',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[700]),
                                            ),
                                            onTap: () {
                                              showSearch(
                                                  context: context,
                                                  delegate: DataSearch(
                                                      controller: _controller));
                                            },
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.search),
                                          onPressed: () {
                                            if (_controller.text.length > 0) {
                                              print(_controller.text);
                                            _setDesCountry(_controller.text);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchScreen()));
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 5,
                              left: 5,
                              right: 5,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Color(0xFF1443A1),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "Your Passport Stats",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        print("Tap Visa Free");
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "Visa Free",
                                            style: TextStyle(
                                              color: Colors.green[300],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "$visa_free",
                                            style: TextStyle(
                                              color: Colors.green[300],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print("Tap Visa-on-Arrival");
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "Visa On Arrival",
                                            style: TextStyle(
                                              color: Colors.orange[300],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "$visa_on_arrival",
                                            style: TextStyle(
                                              color: Colors.orange[300],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print("Tap Visa Required");
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "Visa Required",
                                            style: TextStyle(
                                              color: Colors.red[400],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "$visa_required",
                                            style: TextStyle(
                                              color: Colors.red[400],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                'https://www.passportindex.org/countries/${cCode.toLowerCase()}.png',
                                width: 300,
                                height: 425,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 7),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FlatButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          side: BorderSide(
                                              color: Colors.black, width: 2),
                                        ),
                                        color: Colors.white,
                                        child: Text("Learn More"),
                                        onPressed: () {
                                          print("link pressed.");
                                          openBrowserTab(
                                              countryData[cCode]['url']);
                                        })
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                  child: Wrap(
                children: [
                  Text(
                    "Loading...",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ));
            }
          },
        ));
  }
}
