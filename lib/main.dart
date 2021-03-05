import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:visa_checker/common/models/country.dart';
import 'package:visa_checker/screens/splashScreen.dart';

import 'common/constants.dart';

void main() {
  runApp(
    ChangeNotifierProvider<Country>(
      create: (context) => Country(),
      child: VisaChecker(),
    ),
  );
}

class VisaChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: kScaffoldColor,
        primaryColor: kPrimaryColor,
      ),
      home: SplashScreen(),
    );
  }
}
