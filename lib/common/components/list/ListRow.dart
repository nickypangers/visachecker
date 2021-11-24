import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visachecker/common/helpers/colours.dart';
import 'package:visachecker/common/models/country.dart';
import 'package:visachecker/common/models/country_list.dart';
import 'package:visachecker/common/models/navigation.dart';
import 'package:visachecker/common/models/visa.dart';

class ListRow extends StatelessWidget {
  // const ListRow({Key? key}) : super(key: key);

  final String countryName;
  final Destination destination;

  ListRow({required this.countryName, required this.destination, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Country country = Provider.of<CountryList>(context, listen: false)
        .getCountryByCode(destination.code!);
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide())),
      child: GestureDetector(
        onTap: () {
          Provider.of<NavigationState>(context, listen: false)
              .setSearchNavigation(destinationCountry: country);
        },
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 9,
                    // horizontal: 8,
                  ),
                  child: Text(countryName),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  height: double.infinity,
                  color: getColor(destination.category!),
                  child: Center(
                      child: Text(
                    destination.status!,
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
