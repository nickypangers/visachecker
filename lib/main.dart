import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:visa_checker/common/models/country.dart';
import 'package:visa_checker/common/models/navigation.dart';
import 'package:visa_checker/common/models/visa.dart';
import 'package:visa_checker/screens/splashScreen.dart';

import 'common/constants.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Country>(create: (_) => Country()),
        ChangeNotifierProvider<NavigationState>(
            create: (_) => NavigationState()),
        ChangeNotifierProvider<VisaList>(create: (_) => VisaList()),
      ],
      child: VisaChecker(),
    ),
  );
}

class VisaChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
