import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/radii.dart';

class Styles {
  static const Color storyColor = Color(0xFF6C6A71);
  static const Color notCompletelyWhite = Color(0xFFECECEC);

  static Color getHighlightColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? const Color(0xFFE9E8EA)
        : const Color(0xFF39383C);
  }

  static const Color primary = Color(0xFFFF5610);
  static const Color secondary = Color(0xff0584FE);

  static const Color darkSurface = Color(0xFF1D1B1D);
  static const Color onDarkSurface = notCompletelyWhite;

  static const Color lightSurface = Color(0xffF2F1F5);
  static const Color onLightSurface = Color(0xff222222);

  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      surface: lightSurface,
      onSurface: onLightSurface,
      primary: primary,
      onPrimary: Colors.black,
      primaryContainer: Color(0xffe07356),
      secondary: secondary,
      secondaryContainer: Color(0xff483F6C),
      onSecondary: Colors.white,
      background: Color(0xfff3f6f9),
      onBackground: Color(0xff222222),
    ),
    shadowColor: const Color(0xff222222).withOpacity(0.05),
    fontFamily: 'Nunito',
    dividerColor: const Color(0xff6C6F8D),
    canvasColor: const Color(0x7fc3e8f3),
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      surface: darkSurface,
      onSurface: onDarkSurface,
      primary: primary,
      onPrimary: notCompletelyWhite,
      primaryContainer: Color(0xffe07356),
      secondary: secondary,
      secondaryContainer: Color(0xffB794FF),
      onSecondary: notCompletelyWhite,
      background: Colors.yellow,
      onBackground: Colors.green,
    ),
    textTheme: lightTheme.textTheme.apply(
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
    checkboxTheme:
        CheckboxThemeData(fillColor: MaterialStateProperty.all(primary)),
    switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(primary),
        trackColor: MaterialStateProperty.resolveWith((states) =>
            states.contains(MaterialState.selected) ? primary : null)),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: Radii.defaultRadius,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: Radii.defaultRadius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: Radii.defaultRadius,
      ),
      filled: true,
      fillColor: Colors.black,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
  );
}
