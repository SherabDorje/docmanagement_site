import 'package:flutter/material.dart';

final ThemeData appThemeDataDark = ThemeData(
  primaryColor: const Color.fromRGBO(57, 2, 75, 1),
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontFamily: 'Roboto', fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
);
