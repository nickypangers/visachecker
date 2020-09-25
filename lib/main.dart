import 'dart:convert';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visachecker/admanager/admanager.dart';
import 'package:visachecker/services/dataClass.dart';
import 'drawer.dart';
import 'search.dart';
import 'services/Key.dart';
import 'services/SearchList.dart';
import 'services/CountryData.dart';
import 'splash.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Montserrat'),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String visaFree = "";
  String visaOnArrival = "";
  String visaRequired = "";

  List<dynamic> vfreeList;
  List<dynamic> voaList;
  List<dynamic> vrList;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _controller = TextEditingController();

  String cCode, cName;

  Future passportBuilder;

  _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("You are not connected to the internet."),
          content: Text(
              "This app requires internet access in order to function properly."),
          actions: [
            FlatButton(
              child: Text("Understood"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  AdmobBannerSize bannerSize = AdmobBannerSize.BANNER;

  @override
  initState() {
    super.initState();

    if (Platform.isIOS) {
      Admob.requestTrackingAuthorization();
    }
    passportBuilder = _passportCountry();
    print("Name: $cName");
    print("Code: $cCode");
    _checkConnection();
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
          visaFree = data.vf;
          visaOnArrival = data.voa;
          visaRequired = data.vr;
        });
      });
    });
    _countryList();
  }

  _countryList() async {
    fetchCountryList().then((value) {
      CountryList data = value;
      setState(() {
        vfreeList = data.vf;
        voaList = data.voa;
        vrList = data.vr;
        print(
            "VF: ${vfreeList.length} VOA: ${voaList.length} VR: ${vrList.length}");
      });
    });
  }

  Future<CountryList> fetchCountryList() async {
    var url = "https://passportvisa-api.herokuapp.com/list/api/$cCode";
    var response = await http.get(url);
    var parsedJson = json.decode(response.body);
    print(parsedJson);
    var countryList = CountryList(parsedJson);
    return countryList;
  }

  Future<Country> fetchCountry() async {
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

  Widget visaList(List<dynamic> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: SizedBox(
              width: 64,
              height: 64,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.network(
                    "https://www.countryflags.io/${list[index]}/flat/64.png"),
              ),
            ),
            title: Text(reverseSearch(list[index])),
          );
        });
  }

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        print('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        print('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        print('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        showDialog(
          context: scaffoldState.currentContext,
          builder: (BuildContext context) {
            return WillPopScope(
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Reward callback fired. Thanks Andrew!'),
                    Text('Type: ${args['type']}'),
                    Text('Amount: ${args['amount']}'),
                  ],
                ),
              ),
              onWillPop: () async {
                scaffoldState.currentState.hideCurrentSnackBar();
                return true;
              },
            );
          },
        );
        break;
      default:
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
                                            readOnly: true,
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
                                        showDialog(
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                              title: Center(
                                                child: Text(
                                                  "Visa Free: ${vfreeList.length}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              content: Container(
                                                width: double.maxFinite,
                                                height: 300,
                                                child: visaList(vfreeList),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("Back"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                        );
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
                                            "$visaFree",
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
                                        showDialog(
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                              title: Center(
                                                child: Text(
                                                  "Visa On Arrival: ${voaList.length}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              content: Container(
                                                width: double.maxFinite,
                                                height: 300,
                                                child: visaList(voaList),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("Back"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                        );
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
                                            "$visaOnArrival",
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
                                        showDialog(
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                              title: Center(
                                                child: Text(
                                                  "Visa Required: ${vrList.length}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              content: Container(
                                                width: double.maxFinite,
                                                height: 300,
                                                child: visaList(vrList),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("Back"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                        );
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
                                            "$visaRequired",
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
                          child: AdmobBanner(
                            adUnitId: AdManager.bannerAdUnitId,
                            adSize: bannerSize,
                            listener: (AdmobAdEvent event,
                                Map<String, dynamic> args) {
                              handleEvent(event, args, 'Banner');
                            },
                            onBannerCreated:
                                (AdmobBannerController controller) {},
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
                  CircularProgressIndicator(),
                ],
              ));
            }
          },
        ));
  }
}
