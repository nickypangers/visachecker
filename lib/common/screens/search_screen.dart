import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visachecker/common/models/country.dart';
import 'package:visachecker/common/models/country_list.dart';
import 'package:visachecker/common/utils/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Country passportCountry;
  Country? destinationCountry;
  List<Country>? countryList;

  @override
  void initState() {
    super.initState();
    passportCountry = Provider.of<Country>(context, listen: false).getCountry;
    print(passportCountry.code);
    countryList =
        Provider.of<CountryList>(context, listen: false).getCountryList;
  }

  @override
  Widget build(BuildContext context) {
    const _sidebarPadding = kSidebarMargin + kTabWidth + 5;
    const _padding = 20.0;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: _sidebarPadding,
          top: _padding,
          right: _padding,
          bottom: _padding,
        ),
        child: Column(
          children: [
            DropdownSearch<Country>(
              mode: Mode.BOTTOM_SHEET,
              items: countryList,
              dropdownSearchDecoration: InputDecoration(
                labelText: "Passport",
              ),
              itemAsString: (country) => country!.getCountryName ?? "",
              selectedItem: passportCountry,
              // popupItemDisabled: ,
              onChanged: (country) {
                setState(() {
                  passportCountry = country!;
                  print(passportCountry.name);
                });
              },
              // selectedItems: ["Brazil"],
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownSearch<Country>(
              mode: Mode.BOTTOM_SHEET,
              items: countryList,
              dropdownSearchDecoration: InputDecoration(
                labelText: "Destination",
              ),
              itemAsString: (country) => country!.getCountryName ?? "",
              selectedItem: destinationCountry,
              onChanged: (country) {
                setState(() {
                  destinationCountry = country!;
                  print(destinationCountry!.name);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
