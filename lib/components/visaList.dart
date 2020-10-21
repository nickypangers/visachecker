import 'package:flutter/material.dart';
import 'package:visa_checker/services/Key.dart';

class VisaList extends StatefulWidget {
  VisaList({this.list});

  final List<dynamic> list;
  @override
  _VisaListState createState() => _VisaListState();
}

class _VisaListState extends State<VisaList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: SizedBox(
            width: 64,
            height: 64,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  "https://www.countryflags.io/${widget.list[index]}/flat/64.png"),
            ),
          ),
          title: Text(reverseSearch(widget.list[index])),
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
