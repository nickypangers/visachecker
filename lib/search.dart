import 'package:flutter/material.dart';
import 'services/SearchList.dart';
import 'services/Key.dart';
import 'main.dart';
import 'settings.dart';
import 'services/VisaData.dart';

class SearchScreen extends StatefulWidget {
  final String countryName;
  final String countryCode;
  final String passCode;
  final String desCode;

  const SearchScreen(
      {Key key,
      @required this.countryName,
      this.countryCode,
      this.passCode,
      this.desCode})
      : super(key: key);

  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  static String cName, cCode;
  static String result = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _passportController = new TextEditingController();
  TextEditingController _desController = new TextEditingController();

  @override
  void initState() {
    cName = widget.countryName;
    cCode = widget.countryCode;
    if (widget.desCode != null) {
      _passportController.text = widget.passCode;
      _desController.text = widget.desCode;
    }
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
                              HomeScreen(
                                countryName: cName,
                                countryCode: cCode,
                              )));
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
                  Navigator.pop(context);
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
                              SettingsScreen(
                                  countryName: cName, countryCode: cCode)));
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
                          }
                          ;
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
