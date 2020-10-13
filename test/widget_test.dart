// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visachecker/screens/contact.dart';
import 'package:visachecker/screens/home.dart';

Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}

void main() {
  testWidgets('Home Screen Test', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(HomeScreen()));

    expect(find.byType(FutureBuilder), findsOneWidget);
  });

  testWidgets('Contact Screen Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(buildTestableWidget(ContactScreen()));

    expect(find.byType(TextField), findsWidgets);
  });
}
