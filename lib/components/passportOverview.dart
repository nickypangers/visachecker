import 'package:flutter/material.dart';
import 'package:visa_checker/components/visaList.dart';

class PassportOverview extends StatefulWidget {
  PassportOverview({
    @required this.vr,
    @required this.voa,
    @required this.vf,
    @required this.cb,
    @required this.na,
    @required this.vrList,
    @required this.voaList,
    @required this.vfList,
    @required this.cbList,
    @required this.naList,
  });

  final String vr, voa, vf, cb, na;
  final List<dynamic> vrList, voaList, vfList, cbList, naList;

  @override
  PassportOverviewState createState() => PassportOverviewState();
}

class PassportOverviewState extends State<PassportOverview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 5,
        left: 5,
        right: 5,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Color(0xFF1443A1),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "Passport Overview",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            "Visa Free: ${widget.vfList.length}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        content: Container(
                          width: double.maxFinite,
                          height: 300,
                          child: VisaList(list: widget.vfList),
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
                      "${widget.vf}",
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
                            "Visa On Arrival: ${widget.voaList.length}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        content: Container(
                          width: double.maxFinite,
                          height: 300,
                          child: VisaList(list: widget.voaList),
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
                      "${widget.voa}",
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
                            "Visa Required: ${widget.vrList.length}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        content: Container(
                          width: double.maxFinite,
                          height: 300,
                          child: VisaList(list: widget.vrList),
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
                      "${widget.vr}",
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
          (widget.cbList != null &&
                  widget.naList != null &&
                  widget.cbList.length == 0 &&
                  widget.naList.length == 0)
              ? Container()
              : Column(
                  children: [
                    Text(
                      "Travel Restrictions",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("Tap Travel Ban");
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
                                          "Travel Ban: ${widget.cbList.length}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      content: Container(
                                        width: double.maxFinite,
                                        height: 300,
                                        child: VisaList(list: widget.cbList),
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
                                    "Travel Ban",
                                    style: TextStyle(
                                      color: Colors.red[400],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${widget.cb}",
                                    style: TextStyle(
                                      color: Colors.red[400],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("Tap No Admission");
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
                                          "No Admission: ${widget.naList.length}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      content: Container(
                                        width: double.maxFinite,
                                        height: 300,
                                        child: VisaList(list: widget.naList),
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
                                    "No Admission",
                                    style: TextStyle(
                                      color: Colors.red[400],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${widget.na}",
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
                  ],
                ),
        ],
      ),
    );
  }
}
