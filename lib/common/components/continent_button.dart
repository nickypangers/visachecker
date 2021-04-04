import 'package:flutter/material.dart';

enum Continent {
  asia,
  africa,
  europe,
  oceania,
  southAmerica,
  northAmerica,
}

class ContinentButton extends StatelessWidget {
  final Continent continent;
  final Color color;

  ContinentButton({this.continent, this.color});

  String _getContinentTitle(Continent continent) {
    switch (continent) {
      case Continent.asia:
        return 'Asia';
      case Continent.africa:
        return 'Africa';
      case Continent.europe:
        return 'Europe';
      case Continent.oceania:
        return 'Oceania';
      case Continent.southAmerica:
        return 'South America';
      case Continent.northAmerica:
        return 'North America';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 150,
      // height: 50,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: color,
      ),
      child: Text(
        _getContinentTitle(continent),
      ),
    );
  }
}
