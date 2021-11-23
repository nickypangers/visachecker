import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visachecker/common/models/country.dart';

class SearchResultTile extends StatelessWidget {
  final Country country;

  const SearchResultTile({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dimension = 50.0;
    return ListTile(
      leading: SizedBox(
        height: dimension,
        width: dimension,
        child: SvgPicture.asset(
            "assets/flags/${country.getCountryCode!.toLowerCase()}.svg"),
      ),
      title: Text(country.getCountryName!),
    );
  }
}
