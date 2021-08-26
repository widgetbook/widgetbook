import 'package:flutter/material.dart';
import 'package:widgetbook/src/utils/typography.dart' as util;
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static const Color storyColor = Color(0xFF6C6A71);
  static const Color notCompletelyWhite = Color(0xFFECECEC);

  static Color getHighlightColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Color(0xFFE9E8EA)
        : Color(0xFF39383C);
  }

  static const Color primary = Color(0xFFFF5610);
  static const Color secondary = Color(0xff0584FE);

  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      surface: const Color(0xffF2F1F5),
      onSurface: Color(0xff222222),
      primary: primary,
      onPrimary: Colors.black,
      primaryVariant: Color(0xffe07356),
      secondary: secondary,
      secondaryVariant: Color(0xff483F6C),
      onSecondary: Colors.white,
      background: Color(0xfff3f6f9),
      onBackground: Color(0xff222222),
    ),
    shadowColor: const Color(0xff222222).withOpacity(0.05),
    textTheme: GoogleFonts.nunitoTextTheme(
      util.Typography.textTheme,
    ),
    dividerColor: const Color(0xff6C6F8D),
    canvasColor: const Color(0x7fc3e8f3),
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFF1D1B1D),
      onSurface: notCompletelyWhite,
      primary: primary,
      onPrimary: notCompletelyWhite,
      primaryVariant: Color(0xffe07356),
      secondary: secondary,
      secondaryVariant: Color(0xffB794FF),
      onSecondary: notCompletelyWhite,
      background: Colors.yellow,
      onBackground: Colors.green,
    ),
    textTheme: GoogleFonts.nunitoTextTheme(
      lightTheme.textTheme,
    ).apply(
      bodyColor: notCompletelyWhite,
      displayColor: notCompletelyWhite,
      decorationColor: notCompletelyWhite,
    ),
    hintColor: const Color(0xFFADADAD),
    shadowColor: const Color(0xff939393).withOpacity(0.05),
    dividerColor: const Color(0xff48445D),
    canvasColor: const Color(0x7f30393E),
    scaffoldBackgroundColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
