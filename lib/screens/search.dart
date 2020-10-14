import 'dart:convert';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visa_checker/components/searchContent.dart';
import 'package:visa_checker/services/prefs.dart';
import '../admanager/admanager.dart';
import '../services/Key.dart';
import '../services/SearchList.dart';
import '../services/currency.dart';
import '../services/dataClass.dart';
import 'drawer.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _passportController = TextEditingController();
  TextEditingController _desController = TextEditingController();

  Future<void> _getDestinationCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String desCountry = prefs.getString('desCountry');
    if (desCountry != null) {
      setState(() {
        _passportController.text = prefs.getString('countryName');
        _desController.text = desCountry;
        prefs.remove('desCountry');
      });
    }
  }

  bool _hasKey = false;

  AdmobBannerSize bannerSize = AdmobBannerSize.BANNER;
  AdmobInterstitial interstitialAd;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  void initState() {
    super.initState();

    setState(() {
      checkHasKey("hasCurrencyApiKey").then((val) {
        _hasKey = (val == null) ? false : val;
        print("show currency rate: $_hasKey");
      });
      getAPIKey().then((val) {
        apiKey = val;
      });
    });
    _getDestinationCountry();
  }

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

  String apiKey;

  Future<String> fetchVisa() async {
    var url =
        "https://passportvisa-api.herokuapp.com/api/${cList[_passportController.text]}/${cList[_desController.text]}";
    var response = await http.get(url);
    var parsedJson = json.decode(response.body);
    var visa = Visa(parsedJson);
    return visa.code;
  }

  Future<String> getAPIKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("CurrencyConverterAPIKey");
  }

  Future<double> getCurrencyRate(String from, String to) async {
    String currencyPair =
        "${currencyList[cList[from]]}_${currencyList[cList[to]]}";
    print(currencyPair);
    var url =
        "https://free.currconv.com/api/v7/convert?q=$currencyPair&compact=ultra&apiKey=$apiKey";
    var response = await http.get(url);
    var parsedJson = json.decode(response.body);
    print(parsedJson);
    var cRate = CurrencyRate(currencyPair, parsedJson);
    print("status: ${cRate.status}");
    if (cRate.status == 400) {
      return -1;
    } else {
      return cRate.rate;
    }
  }

  bool _isSearchPressed = false;

  int snackBarSeconds = 1;

  double rate;

  String passportCountry, desCountry;

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
                      Icons.menu,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Search",
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
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40,
                      right: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: TextField(
                                  readOnly: true,
                                  controller: _passportController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter passport country',
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _isSearchPressed = false;
                                      showSearch(
                                          context: context,
                                          delegate: DataSearch(
                                              controller: _passportController));
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: TextField(
                                  readOnly: true,
                                  controller: _desController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter destination country',
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _isSearchPressed = false;
                                      showSearch(
                                          context: context,
                                          delegate: DataSearch(
                                              controller: _desController));
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            FlatButton(
                              child: Icon(Icons.clear_all),
                              onPressed: () {
                                _passportController.text = "";
                                _desController.text = "";
                                setState(() {
                                  passportCountry = "";
                                  desCountry = "";
                                  _isSearchPressed = false;
                                });
                              },
                            ),
                            FlatButton(
                              child: Icon(Icons.search),
                              onPressed: (() =>
                                  setState(() => _isSearchPressed = true)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: AdmobBanner(
                      adUnitId: AdManager.searchBannerAdUnitId,
                      adSize: bannerSize,
                      listener:
                          (AdmobAdEvent event, Map<String, dynamic> args) {
                        handleEvent(event, args, 'Banner');
                      },
                      onBannerCreated: (AdmobBannerController controller) {},
                    ),
                  ),
                  _isSearchPressed
                      ? SearchContent(
                          passportCountry: _passportController.text,
                          desCountry: _desController.text,
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
