import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/SearchList.dart';
import 'services/Key.dart';
import 'drawer.dart';
import 'services/VisaData.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  static String result = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _passportController = new TextEditingController();
  TextEditingController _desController = new TextEditingController();

  Future<void> _getDestinationCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String desCountry = prefs.getString('desCountry');
    if (desCountry != null) {
      setState((){
        _passportController.text = prefs.getString('countryName');
        _desController.text = desCountry;
        prefs.remove('desCountry');
      });
    }
  }

  @override
  void initState() {
    _getDestinationCountry();
    super.initState();
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
      body: SingleChildScrollView(
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
                      "Search",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        //fontFamily: 'Monts
                        // errat',
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                            controller: _passportController,
                            decoration: InputDecoration(
                              hintText: 'Enter passport country',
                            ),
                            onTap: () {
                              showSearch(
                                  context: context,
                                  delegate: DataSearch(
                                      controller: _passportController));
                            },
                          ),
                        ),
                        Container(
                          child: TextField(
                            controller: _desController,
                            decoration: InputDecoration(
                              hintText: 'Enter destination country',
                            ),
                            onTap: () {
                              showSearch(
                                  context: context,
                                  delegate:
                                      DataSearch(controller: _desController));
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
                            result = "";
                          });
                        },
                      ),
                      FlatButton(
                        child: Icon(Icons.search),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (_passportController.text == _desController.text ||
                              _passportController.text.length == null ||
                              _desController.text.length == null) {
                            setState(() {
                              result = "";
                            });
                            return;
                          } else {
                            setState(() {
                              print("passport: ${_passportController.text}");
                              print("destination: ${_desController.text}");
                              result = vData[cList[_passportController.text]]
                                  [cList[_desController.text]];
                            });
                            if (result == "VR") {
                              result = "Visa Required";
                            } else if (result == "VOA" || result == "ETA") {
                              result = "Visa on arrival";
                            } else {
                              result = result + " days";
                            }
                            print(result);
                          };
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(result),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
