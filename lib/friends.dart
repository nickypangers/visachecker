import 'dart:convert';
import 'services/Key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'search.dart';
import 'services/dataClass.dart';
import 'services/friendObject.dart';
import 'drawer.dart';
import 'services/SearchList.dart';
import 'package:flip_card/flip_card.dart';
import 'package:http/http.dart' as http;

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _locController = TextEditingController();

  List<Friend> friends = [];

  Future visaBuilder;

  String pCountry;
  String desCountry;
  String result;

  @override
  initState() {
    super.initState();
    _pCountry();
  }

  _setDesCountry(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('desCountry', value);
  }

  Color resultColor(String result) {
    if (result == "VR") {
      return Colors.red[400];
    } else if (result == "VOA" || result == "ETA") {
      return Colors.blue[400];
    } else if (result == "VF") {
      return Colors.green[400];
    } else {
      return Colors.green[400];
    }
  }

  Future<String> fetchVisa() async {
    var url =
        "https://passportvisa-api.herokuapp.com/api/${cList[pCountry]}/${cList[desCountry]}";
    var response = await http.get(url);
    var parsedJson = json.decode(response.body);
    var visa = Visa(parsedJson);
    return visa.code;
  }

  _pCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pCountry = prefs.getString('countryName');
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 30, bottom: 0),
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
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Friends",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Add Friend"),
                                  content: Column(
                                    children: [
                                      TextField(
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Name',
                                        ),
                                      ),
                                      TextField(
                                        controller: _locController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Country',
                                        ),
                                        onTap: () {
                                          showSearch(
                                            context: context,
                                            delegate: DataSearch(
                                                controller: _locController),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Back"),
                                      onPressed: () {
                                        _nameController.clear();
                                        _locController.clear();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("Add"),
                                      onPressed: () {
                                        desCountry = _locController.text;
                                        // String name = _nameController.text;
                                        String result;
                                        fetchVisa().then((value) {
                                          result = value;
                                          setState(() {
                                            friends.add(Friend(
                                              name: _nameController.text,
                                              country: _locController.text,
                                              result: result,
                                              color: resultColor(result),
                                            ));
                                            _nameController.clear();
                                            _locController.clear();
                                            Navigator.of(context).pop();
                                          });
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                friends.length,
                (index) {
                  return Card(
                    elevation: 0,
                    margin: EdgeInsets.only(
                        left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
                    child: FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      speed: 1000,
                      onFlipDone: (status) {
                        print(status);
                      },
                      front: Container(
                        decoration: BoxDecoration(
                          color: friends[index].color,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 48,
                              height: 48,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                    "https://www.countryflags.io/${cList[friends[index].country]}/flat/64.png"),
                              ),
                            ),
                            Text(
                              friends[index].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      back: Container(
                        decoration: BoxDecoration(
                          color: friends[index].color,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(friends[index].result),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
