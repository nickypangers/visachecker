import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visachecker/common/models/country.dart';
import 'package:visachecker/common/models/country_list.dart';
import 'package:visachecker/common/models/search.dart';
import 'package:visachecker/common/utils/constants.dart';

class SearchScreen extends StatefulWidget {
  final Country? passportCountry;
  final Country? destinationContry;
  SearchScreen({Key? key, this.passportCountry, this.destinationContry})
      : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Country? passportCountry;
  Country? destinationCountry;
  List<Country>? countryList;

  @override
  void initState() {
    super.initState();
    countryList =
        Provider.of<CountryList>(context, listen: false).getCountryList;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    passportCountry =
        Provider.of<Search>(context, listen: true).passportCountry;

    destinationCountry =
        Provider.of<Search>(context, listen: true).destinationCountry;
    if (this.widget.passportCountry != null) {
      Provider.of<Search>(context)
          .setPassportCountry(this.widget.passportCountry);
    } else {
      var currentCountry =
          Provider.of<Country>(context, listen: false).getCountry;
      Provider.of<Search>(context).setPassportCountry(currentCountry);
    }

    if (this.widget.destinationContry != null) {
      Provider.of<Search>(context)
          .setPassportCountry(this.widget.destinationContry);
    }
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
            buildCountryListDropdownSearch(
              label: "Passport",
              country: passportCountry,
            ),
            const SizedBox(
              height: 10,
            ),
            buildCountryListDropdownSearch(
              label: "Destination",
              country: destinationCountry,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCountryListDropdownSearch({
    required String label,
    required Country? country,
  }) {
    return DropdownSearch<Country>(
      mode: Mode.BOTTOM_SHEET,
      items: countryList,
      dropdownSearchDecoration: InputDecoration(labelText: label),
      itemAsString: (country) => country!.getCountryName ?? "",
      selectedItem: country,
      onChanged: (onChangedCountry) {
        setState(() {
          country = onChangedCountry!;
          print(country!.code);
        });
      },
    );
  }
}
