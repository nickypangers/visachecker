import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:visachecker/common/models/country.dart';
import 'package:visachecker/common/models/country_list.dart';
import 'package:visachecker/common/models/navigation.dart';
import 'package:visachecker/common/models/visa.dart';
import 'package:visachecker/common/screens/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common/utils/constants.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<CountryList>(create: (_) => CountryList()),
    ChangeNotifierProvider<Country>(create: (_) => Country()),
    ChangeNotifierProvider<CountryCategoryList>(
        create: (_) => CountryCategoryList()),
    ChangeNotifierProvider<NavigationState>(create: (_) => NavigationState()),
    ChangeNotifierProvider<VisaData>(create: (_) => VisaData()),
  ], child: const VisaChecker()));
}

class VisaChecker extends StatelessWidget {
  const VisaChecker({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: kScaffoldColor,
        primaryColor: kPrimaryColor,
      ),
      home: const SplashScreen(),
    );
  }
}
