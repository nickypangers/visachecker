import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visachecker/common/components/list/ListHeader.dart';
import 'package:visachecker/common/components/list/ListRow.dart';
import 'package:visachecker/common/models/country.dart';
import 'package:visachecker/common/models/country_list.dart';
import 'package:visachecker/common/models/visa.dart';
import 'package:visachecker/common/utils/constants.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: kSidebarMargin + kTabWidth + 5),
        child: SingleChildScrollView(
          child: Column(
            children: _buildDataRows(context),
          ),
        ),
      ),
    );
  }

  Color getColor(String category) {
    switch (category) {
      case kVisaRequired:
        return kVisaRequiredColor;
      case kVisaOnArrival:
        return kVisaOnArrivalColor;
      case kVisaFree:
        return kVisaFreeColor;
      case kCovidBan:
        return kCovidBanColor;
      case kNoAdmission:
        return kNoAdmissionColor;
      default:
        return kNoAdmissionColor;
    }
  }

  List<Widget> _buildDataRows(BuildContext context) {
    List<Widget> widgetList = [];

    widgetList.add(
      ListHeader(leftTitle: "Country Name", rightTitle: "Status"),
    );

    String currentCountryCode =
        Provider.of<Country>(context, listen: false).getCountryCode!;

    List<Destination> destinationList =
        Provider.of<VisaData>(context, listen: false)
            .getData(currentCountryCode);

    destinationList.forEach((element) {
      Country country = Provider.of<CountryList>(context, listen: false)
          .getCountryByCode(element.code!);
      widgetList.add(
          ListRow(countryName: country.getCountryName!, destination: element));
    });

    return widgetList;
  }
}
