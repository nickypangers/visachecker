import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visa_checker/common/models/country.dart';

class SearchResultTile extends StatelessWidget {
  final Country country;

  SearchResultTile({this.country});

  @override
  Widget build(BuildContext context) {
    var dimension = 50.0;
    return ListTile(
      leading: Container(
        height: dimension,
        width: dimension,
        child: SvgPicture.asset(country.flagUrl),
      ),
      title: Text(country.countryName),
    );
  }
}
