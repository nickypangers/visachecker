import 'dart:convert';
import 'services/Key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'search.dart';
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

  List<DropdownMenuItem<int>> cardOptions = [
    DropdownMenuItem(
      child: Text("Edit"),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text("Delete"),
      value: 2,
    )
  ];

  List<Friend> friends = [];

  Future visaBuilder;

  String pCountry;
  String desCountry;
  String result;

  @override
  initState() {
    super.initState();
    _pCountry();
    _checkFriendsList();
  }

  Color resultColor(int index) {
    Color rColor;
    if (pCountry == friends[index].country) {
      setState(() {
        rColor = Colors.orange[400];
      });
    } else {
      if (friends[index].result == "VR") {
        setState(() {
          rColor = Colors.red[400];
        });
      } else if (friends[index].result == "VOA" ||
          friends[index].result == "ETA") {
        setState(() {
          rColor = Colors.blue[400];
        });
      } else if (friends[index].result == "VF") {
        setState(() {
          rColor = Colors.green[400];
        });
      } else {
        setState(() {
          rColor = Colors.green[400];
        });
      }
    }
    return rColor;
  }

  Future<Friend> fetchVisa(String name, String desCountry) async {
    var url =
        "https://passportvisa-api.herokuapp.com/api/${cList[pCountry]}/${cList[desCountry]}";
    var response = await http.get(url);
    var parsedJson = json.decode(response.body);
    var visa = Visa(parsedJson);
    Friend newFriend = Friend(
      name: name,
      country: desCountry,
      result: visa.code,
    );
    return newFriend;
  }

  String resultText(int index) {
    if (pCountry == friends[index].country) {
      return "Same Country";
    } else {
      if (friends[index].result == "VR") {
        return "Visa Required";
      } else if (friends[index].result == "VOA" ||
          friends[index].result == "ETA") {
        return "Visa on arrival";
      } else if (friends[index].result == "VF") {
        return "Visa Free";
      } else {
        return "Visa Free\n${friends[index].result} days";
      }
    }
  }

  Future<String> fetchVisaValue(String name, String desCountry) async {
    var url =
        "https://passportvisa-api.herokuapp.com/api/${cList[pCountry]}/${cList[desCountry]}";
    var response = await http.get(url);
    var parsedJson = json.decode(response.body);
    var visa = Visa(parsedJson);
    return visa.code;
  }
  
  _checkFriendsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var returnList = prefs.getString('friendsList');
    if (returnList != null) {
      List readList = jsonDecode(returnList);
      setState(() {
        friends = readList.map((val) => Friend.fromJson(val)).toList();
        for (int i = 0; i < friends.length; i++) {
          fetchVisaValue(pCountry, friends[i].country).then((value) {
            if (value != friends[i].result) {
              setState(() {
                friends[i].result = value;
              });
            }
          });
        }
      });
      print(friends);
    }
  }

  _saveFriend(List<Friend> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('friendsList', jsonEncode(list));
    String readList = prefs.getString('friendsList');
    print(readList);
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
                                        print("Adding ${_nameController.text}, ${_locController.text}");
                                        fetchVisa(_nameController.text,
                                                _locController.text)
                                            .then((value) {
                                          friends.add(value);
                                          setState(() {
                                            _nameController.clear();
                                            _locController.clear();
                                          });
                                          _saveFriend(friends);
                                          Navigator.of(context).pop();
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
                  return GestureDetector(
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.only(
                          left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
                      child: FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        speed: 700,
                        onFlipDone: (status) {
                          print(status);
                        },
                        front: Container(
                          decoration: BoxDecoration(
                            color: resultColor(index),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 64,
                                height: 64,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.network(
                                      "https://www.countryflags.io/${cList[friends[index].country]}/flat/64.png"),
                                ),
                              ),
                              Text(
                                friends[index].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        back: Container(
                          decoration: BoxDecoration(
                            color: resultColor(index),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      resultText(index),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        alignment: Alignment.bottomLeft,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            child: AlertDialog(
                                              title: Text("Edit Friend"),
                                              content: Column(
                                                children: [
                                                  TextField(
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    controller: _nameController..text = friends[index].name,
                                                  ),
                                                  TextField(
                                                    controller: _locController..text = friends[index].country,
                                                    onTap: () {
                                                      showSearch(
                                                        context: context,
                                                        delegate: DataSearch(
                                                            controller:
                                                                _locController),
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
                                                  child: Text("Confirm"),
                                                  onPressed: () {
                                                    fetchVisa(
                                                            _nameController
                                                                .text,
                                                            _locController.text)
                                                        .then((value) {
                                                      friends[index] = value;
                                                      setState(() {
                                                        _nameController.clear();
                                                        _locController.clear();
                                                      });
                                                      _saveFriend(friends);
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.delete),
                                          alignment: Alignment.bottomRight,
                                          onPressed: () {
                                            setState(() {
                                              friends.removeAt(index);
                                              _saveFriend(friends);
                                            });
                                            print("delete tapped");
                                          })
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
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
