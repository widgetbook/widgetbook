import 'package:flutter/material.dart';
import 'package:meal_app/constants/border.dart';
import 'package:meal_app/constants/color.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookTheme(name: 'Dark', isDefault: true)
ThemeData getDarkThemeData() => ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,
    );

ThemeData getDarkTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.blue,
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
          decorationColor: Colors.white,
        ),
    scaffoldBackgroundColor: ColorConstants.backgroundColorDark,
    primaryColor: ColorConstants.primaryColor,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          ColorConstants.primaryColor,
        ),
        elevation: MaterialStateProperty.all<double>(0),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              BorderConstants.buttonRadius,
            ),
          ),
        ),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      color: ColorConstants.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          BorderConstants.borderRadius,
        ),
      ),
    ),
  );
}
