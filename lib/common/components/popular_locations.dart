import 'package:flutter/material.dart';

class PopularLocations extends StatefulWidget {
  @override
  _PopularLocationsState createState() => _PopularLocationsState();
}

class _PopularLocationsState extends State<PopularLocations> {
  double yPadding = 20.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: yPadding),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  "Popular Locations",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  "All World",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xff63bed5)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: buildPageView(),
        ),
      ],
    );
  }

  Widget buildPageView() {
    return PageView(
      children: [
        buildPage(color: Colors.red),
        buildPage(color: Colors.yellow),
        buildPage(color: Colors.green),
      ],
    );
  }

  Widget buildPage({Color color}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 70,
      itemBuilder: (context, index) {
        return Container(
          color: color,
          child: Text("$index"),
        );
      },
    );
  }
}
