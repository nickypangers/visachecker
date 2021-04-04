import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visa_checker/common/models/country.dart';

class BottomModalSheet extends StatelessWidget {
  final Country country;

  BottomModalSheet({this.country});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(country.getFlagUrl),
        Text("${country.getCountryName}"),
      ],
    );
  }
}
