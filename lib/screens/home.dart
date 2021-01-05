import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'splashScreen.dart';

class VisaChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: SplashScreen(),
    );
  }
}
