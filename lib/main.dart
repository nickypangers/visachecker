import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'screens/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Montserrat'),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
