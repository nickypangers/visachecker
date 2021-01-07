import 'package:flutter/material.dart';
import 'package:visa_checker/common/constants.dart';

class BottomNavBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<IconData> iconList;

  BottomNavBar({this.defaultSelectedIndex = 0, this.onChange, this.iconList});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  List<IconData> _iconList = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(context) {
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }

    return Container(
      color: kBackgroundColor,
      child: Row(
        children: _navBarItemList,
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / _iconList.length,
        child: Icon(
          icon,
          color: (index == _selectedIndex) ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
