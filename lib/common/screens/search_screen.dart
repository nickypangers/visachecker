import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visachecker/common/helpers/colours.dart';
import 'package:visachecker/common/models/country.dart';
import 'package:visachecker/common/models/country_list.dart';
import 'package:visachecker/common/models/search.dart';
import 'package:visachecker/common/models/visa.dart';
import 'package:visachecker/common/utils/constants.dart';
import 'package:visachecker/manager/request_manager.dart';

class SearchScreen extends StatefulWidget {
  final Country? passportCountry;
  final Country? destinationCountry;
  SearchScreen({Key? key, this.passportCountry, this.destinationCountry})
      : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Country>? countryList;

  @override
  void initState() {
    countryList =
        Provider.of<CountryList>(context, listen: false).getCountryList;
    Future.delayed(Duration.zero, () {
      if (this.widget.passportCountry != null) {
        Provider.of<Search>(context, listen: false)
            .setPassportCountry(this.widget.passportCountry);
      } else {
        Provider.of<Search>(context, listen: false).setPassportCountry(
            Provider.of<Country>(context, listen: false).getCountry);
      }
      if (this.widget.destinationCountry != null) {
        Provider.of<Search>(context, listen: false)
            .setDestinationCountry(this.widget.destinationCountry);
      } else {
        Provider.of<Search>(context, listen: false).setDestinationCountry(null);
      }
    });
    super.initState();
  }

  Future<VisaInfo?> getVisaInfo() async {
    var passportCountry =
        Provider.of<Search>(context, listen: false).passportCountry;
    var destinationCountry =
        Provider.of<Search>(context, listen: false).destinationCountry;

    if (passportCountry == null || destinationCountry == null) {
      return null;
    }

    if (passportCountry == destinationCountry) {
      return null;
    }

    RequestManager requestManager = RequestManager();
    VisaInfo visaInfo = await requestManager.getVisaInfo(
        passportCountry.getCountryCode!, destinationCountry.getCountryCode!);
    return visaInfo;
  }

  Widget buildVisaInfoDuration(VisaInfo visaInfo) {
    switch (visaInfo.getCategory) {
      case kVisaRequired:
        return SizedBox.shrink();
      case kCovidBan:
        return SizedBox.shrink();
      case kNoAdmission:
        return SizedBox.shrink();
      default:
        String duration = visaInfo.getDur + " days";
        if (duration == "") {
          duration = "Not provided";
        }
        return Text("Duration: $duration",
            style: kSearchResultDurationTextStyle);
    }
  }

  Widget buildVisaInfoDisplay(VisaInfo visaInfo) {
    List<Widget> children = [];

    children.add(
      Text(
        visaInfo.getStatus,
        style: kSearchResultStatusTextStyle,
      ),
    );

    children.add(const SizedBox(height: 10));

    children.add(buildVisaInfoDuration(visaInfo));

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      constraints: BoxConstraints(
        minHeight: 100,
      ),
      width: double.infinity,
      color: getColor(visaInfo.getCategory),
      child: Center(
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget buildVisaInfoSection(VisaInfo visaInfo) {
    return Column(
      children: [
        // Text(visaInfo.toString()),
        buildVisaInfoDisplay(visaInfo),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const _sidebarPadding = kSidebarMargin + kTabWidth + 5;
    const _padding = 20.0;

    return Consumer<Search>(
      builder: (context, search, child) {
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
                  country: search.passportCountry,
                  isPassport: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                buildCountryListDropdownSearch(
                  label: "Destination",
                  country: search.destinationCountry,
                  isPassport: false,
                ),
                const SizedBox(
                  height: 70,
                ),
                FutureBuilder<VisaInfo?>(
                  future: getVisaInfo(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (!snapshot.hasData || search.hasNull()) {
                          return SizedBox.shrink();
                        }
                        return buildVisaInfoSection(snapshot.data!);
                      default:
                        return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCountryListDropdownSearch({
    required String label,
    required Country? country,
    required bool isPassport,
  }) {
    return DropdownSearch<Country>(
      mode: Mode.BOTTOM_SHEET,
      items: countryList,
      dropdownSearchDecoration: InputDecoration(labelText: label),
      itemAsString: (country) => country!.getCountryName ?? "",
      selectedItem: country,
      onChanged: (onChangedCountry) {
        setState(() {
          if (isPassport) {
            Provider.of<Search>(context, listen: false)
                .setPassportCountry(onChangedCountry);
          } else {
            Provider.of<Search>(context, listen: false)
                .setDestinationCountry(onChangedCountry);
            debugPrint(Provider.of<Search>(context, listen: false).toString());
          }
        });
      },
    );
  }
}
