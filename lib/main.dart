// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:franks_invoice_tool/prototype/prototype_main_page.dart';

const Color MAIN_COLOR = Color(0xff1513f9);
const Color BACKGROUND_COLOR = Color(0xff293133);
const Color MAIN_TEXT_COLOR = Color(0xffffffff);
const Color ACCENT_COLOR = Color(0xff25dae2);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'frank invoice app',
      theme: ThemeData(
        primaryColor: MAIN_COLOR,
        backgroundColor: BACKGROUND_COLOR,
        scaffoldBackgroundColor: BACKGROUND_COLOR,
        appBarTheme: AppBarTheme(
          backgroundColor: MAIN_COLOR,
          toolbarTextStyle: const TextTheme(
            headline6: TextStyle(
              color: MAIN_TEXT_COLOR,
              fontSize: 25,
            ),
          ).bodyText2,
        ),
        textTheme:
            const TextTheme(bodyText2: TextStyle(color: MAIN_TEXT_COLOR)),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: MAIN_COLOR,
            foregroundColor: MAIN_TEXT_COLOR,
            splashColor: ACCENT_COLOR),
      ),
      home: const PrototypeMainPage(),
    );
  }
}
