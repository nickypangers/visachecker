import 'package:flutter/material.dart';
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
                                          friends.add(Friend(name: _nameController.text, country: _locController.text),);
                                        });
                                        _nameController.clear();
                                        _locController.clear();
                                        Navigator.of(context).pop();
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
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(friends[index].name),
                  subtitle: Text(friends[index].country),
                  onTap: () {},
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
