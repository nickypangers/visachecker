import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visachecker/common/models/country.dart';
import 'package:visachecker/common/models/country_list.dart';
import 'package:visachecker/common/models/visa.dart';
import 'package:visachecker/common/utils/constants.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  // Iterable<Destination> destination =

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: kSidebarMargin + kTabWidth + 10, right: 10),
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text("Country Name"),
                ),
                DataColumn(
                  label: Text("Visa Status"),
                ),
              ],
              rows: _buildDataRows(context),
            ),
          ),
        ),
      ),
    );
  }

  Color getColor(String category) {
    switch (category) {
      case "VR":
        return kVisaRequiredColor;
      case "VOA":
        return kVisaOnArrivalColor;
      case "VF":
        return kVisaFreeColor;
      case "CB":
        return kCovidBanColor;
      case "NA":
        return kNoAdmissionColor;
      default:
        return kNoAdmissionColor;
    }
  }

  List<DataRow> _buildDataRows(BuildContext context) {
    String currentCountryCode =
        Provider.of<Country>(context, listen: false).getCountryCode!;

    List<Destination> destinationList =
        Provider.of<VisaData>(context, listen: false)
            .data![currentCountryCode]!
            .destinations!;

    List<DataRow> dataRowList = [];

    destinationList.forEach((element) {
      Country country = Provider.of<CountryList>(context, listen: false)
          .getCountryByCode(element.code!);
      dataRowList.add(
        DataRow(
          cells: [
            DataCell(
              Container(
                child: Text(country.getCountryName!),
              ),
            ),
            DataCell(
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: getColor(element.category!),
                  child: Center(
                    child: Text(element.status!),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });

    return dataRowList;
  }
}
