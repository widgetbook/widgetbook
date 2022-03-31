import 'package:flutter/material.dart';
import 'package:widgetbook_example/constants/border.dart';
import 'package:widgetbook_example/constants/color.dart';

ThemeData get darkTheme {
  return ThemeData.dark().copyWith(
    textTheme: TextTheme().apply(),
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
