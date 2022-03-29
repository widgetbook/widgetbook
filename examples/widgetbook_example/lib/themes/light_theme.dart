import 'package:flutter/material.dart';
import 'package:widgetbook_example/constants/border.dart';
import 'package:widgetbook_example/constants/color.dart';

ThemeData get lightTheme {
  return ThemeData(
    primarySwatch: Colors.blue,
    textTheme: TextTheme().apply(
      bodyColor: ColorConstants.lightFontColor,
      displayColor: ColorConstants.lightFontColor,
      decorationColor: ColorConstants.lightFontColor,
    ),
    scaffoldBackgroundColor: ColorConstants.backgroundColorLight,
    primaryColor: ColorConstants.primaryColor,
    iconTheme: IconThemeData(
      color: ColorConstants.lightFontColor,
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
