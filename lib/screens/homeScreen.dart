import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visa_checker/common/models/country.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Country>(
      builder: (context, country, child) => Center(
        child: Container(
          child: Text(country.getCountryName),
        ),
      ),
    );
  }
}
