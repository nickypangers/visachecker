import 'package:flutter/material.dart';

import 'drawer.dart';
import 'services/SearchList.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _nameController, _locController = new TextEditingController();

 List<String> friendList = [];
 List<String> friendLoc = [];

  _addFriend(String name, String country) {
    setState(() {
      friendList.add(name);
      friendLoc.add(country);      
    });
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
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Add Friend"),
                                  content: Column(
                                    children: [
                                      TextField(
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
                                                      controller: _locController));
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    FlatButton(
                                      child: Text("Add"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _addFriend(_nameController.text, _locController.text);
                                        print("Name: $friendList, Loc: $friendLoc");
                                        _nameController.clear();
                                        _locController.clear();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("Back"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _nameController.clear();
                                        _locController.clear();
                                      },
                                    ),
                                  ],
                                );
                              }
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
            child: ListView.builder(
              itemCount: friendList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(friendList[index]),
                  subtitle: Text(friendLoc[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
