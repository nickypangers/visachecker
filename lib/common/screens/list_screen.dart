import 'package:flutter/material.dart';
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
      child: Padding(
        padding: const EdgeInsets.only(
            left: kSidebarMargin + kTabWidth + 10, right: 10),
        child: DataTable(
          columns: [
            DataColumn(
              label: Text("Country"),
            ),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(
                  Text('Test'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
