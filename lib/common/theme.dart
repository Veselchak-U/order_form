import 'package:flutter/material.dart';

final theme = ThemeData(
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 6.0,
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      padding: EdgeInsets.all(0),
    ),
  ),
  textTheme: TextTheme(
    headline5: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
);
