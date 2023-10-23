import 'package:cookbook1/utils/color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  ThemeData themedata = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.appRedColor,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      titleMedium: TextStyle(fontWeight: FontWeight.bold),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.black,
      ),
      contentPadding: EdgeInsets.only(top: 12, left: 10),
    ),
    primarySwatch: Colors.red,
    brightness: Brightness.light,
  );
}
