import 'package:flutter/material.dart';
import 'drawer.dart';

class ContactScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _subjectController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

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
                          "Contact Developer",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a subject';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Subject',
                    ),
                    controller: _subjectController,
                    maxLines: null,
                    keyboardType: TextInputType.text,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter message body';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Message',
                    ),
                    controller: _bodyController,
                    maxLines: null,
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
          ),
          FlatButton(
            child: Text("Submit"),
            onPressed: () {
              
            },
          )
        ],
      ),
    );
  }
}
