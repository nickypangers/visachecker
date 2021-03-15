import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visa_checker/common/components/sidebar/sidebar.dart';
import 'package:visa_checker/common/models/country.dart';
import 'package:visa_checker/common/models/navigation.dart';

class ContentScreen extends StatefulWidget {
  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Consumer<Country>(
          builder: (context, currentCountry, child) => Stack(
            children: [
              Consumer<NavigationState>(builder: (context, navigation, child) {
                return SafeArea(child: navigation.getCurrentNavigation());
              }),
              SideBar(),
            ],
          ),
        ),
      ),
    );
  }
}
