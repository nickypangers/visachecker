import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'search.dart';
import 'services/friendObject.dart';
import 'drawer.dart';
import 'services/SearchList.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _locController = TextEditingController();

  List<Friend> friends = [];

  @override
  initState() {
    super.initState();
  }



  _setDesCountry(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('desCountry', value);
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
                                          textCapitalization: TextCapitalization.sentences,
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
                                                    controller:
                                                        _locController));
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
                                          setState(() {
                                            friends.add(
                                              Friend(
                                                  name: _nameController.text,
                                                  country: _locController.text),
                                            );
                                          });
                                          _nameController.clear();
                                          _locController.clear();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
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
            child: ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(friends[index].name),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (DismissDirection direction) {
                    return showDialog(
                        context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Are you sure?"),
                          content: Text("You are about to remove ${friends[index].name} from your friends list, continue?"),
                          actions: [
                            FlatButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                            FlatButton(
                              child: Text("Yes"),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("${friends[index].name} dismissed.")));
                        setState(() {
                          friends.removeAt(index);
                        });
                  },
                  background: Container(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    color: Colors.red,
                  ),
                  child: ListTile(
                    title: Text(friends[index].name),
                    subtitle: Text(friends[index].country),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      _setDesCountry(friends[index].country);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
