import 'package:flutter/material.dart';
import 'package:visa_checker/common/constants.dart';
import 'package:visa_checker/common/transitions/reveal_route.dart';

class BottomNavBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<IconData> iconList;
  final List<Widget> pageList;

  BottomNavBar(
      {this.defaultSelectedIndex = 0,
      this.onChange,
      this.iconList,
      this.pageList});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  List<IconData> _iconList = [];
  List<Widget> _pageList = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
    _pageList = widget.pageList;
  }

  @override
  Widget build(context) {
    List<Widget> _navBarItemList = [];
    List<Widget> _navBarPageList = [];

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
      _navBarPageList.add(_pageList[i]);
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
        Navigator.pushReplacement(
            context,
            RevealRoute(
              page: _pageList[index],
              maxRadius: 800,
              centerAlignment: Alignment.center,
            ));
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / _iconList.length,
        child: Icon(
          icon,
          color: (index == _selectedIndex) ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
