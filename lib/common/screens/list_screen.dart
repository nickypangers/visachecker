import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visachecker/common/models/country.dart';
import 'package:visachecker/common/models/country_list.dart';
import 'package:visachecker/common/models/visa.dart';
import 'package:visachecker/common/utils/constants.dart';
import 'package:visachecker/manager/request_manager.dart';

class ListScreen extends StatefulWidget {
  final CountryCategory countryCategory;

  ListScreen({required this.countryCategory});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<VisaInfo> _visaInfoList = [];

  _initVisaInfoList() {
    String passportCode =
        Provider.of<Country>(context, listen: false).getCountryCode!;
    this.widget.countryCategory.data!.forEach((destinationCode) async {
      VisaInfo visaInfo =
          await RequestManager().getVisaInfo(passportCode, destinationCode);
      debugPrint(visaInfo.toString());
      setState(() {
        _visaInfoList.add(visaInfo);
      });
    });
  }

  @override
  void initState() {
    debugPrint(this.widget.countryCategory.toString());
    _initVisaInfoList();
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
              rows: _buildDataRows(),
            ),
          ),
        ),
      ),
    );
  }

  List<DataRow> _buildDataRows() {
    List<DataRow> dataRowList = [];

    _visaInfoList.forEach((element) {
      Country country = Provider.of<CountryList>(context, listen: false)
          .getCountryByCode(element.destination!);
      dataRowList.add(
        DataRow(
          cells: [
            DataCell(
              Text(country.getCountryName!),
            ),
            DataCell(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.amber,
                  child: Center(
                    child: Text(element.destination!),
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
