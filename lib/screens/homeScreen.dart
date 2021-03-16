import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:visa_checker/common/models/country.dart';

class HomeScreen extends StatelessWidget {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<Country>(
      builder: (context, currentCountry, child) => Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              // padding: EdgeInsets.only(left: 10),
              child: IntrinsicWidth(
                child: Row(
                  children: [
                    Icon(Icons.pin_drop_outlined),
                    Text(currentCountry.getCountryName),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 40.0),
            height: 47,
            child: Row(
              children: [Text("32")],
            ),
          ),
          Container(
            width: size.width,
            height: 500,
            child: PageView(
              controller: _pageController,
              onPageChanged: (pageIndex) {
                print("page: ${pageIndex + 1}");
              },
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                  color: Colors.yellow,
                  child: ListView.builder(
                      itemCount: 40,
                      itemBuilder: (context, index) => ListTile(
                            title: Text("$index"),
                          )),
                ),
                Container(
                  color: Colors.red,
                  child: Center(
                    child: Text("2"),
                  ),
                ),
                Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text("3"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
