import 'package:flutter/material.dart';

class Themes {
  static const _darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFA1C9FF),
    onPrimary: Color(0xFF00325A),
    primaryContainer: Color(0xFF004880),
    onPrimaryContainer: Color(0xFFD2E4FF),
    secondary: Color(0xFFB5C8E4),
    onSecondary: Color(0xFF1F3148),
    secondaryContainer: Color(0xFF36485F),
    onSecondaryContainer: Color(0xFFD2E4FF),
    tertiary: Color(0xFFDDBAF0),
    onTertiary: Color(0xFF402551),
    tertiaryContainer: Color(0xFF573B69),
    onTertiaryContainer: Color(0xFF573B69),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFB4AB),
    background: Color(0xFF1A1C1E),
    onBackground: Color(0xFFE3E2E6),
    surface: Color(0xFF121316),
    onSurface: Color(0xFFE3E2E6),
    surfaceVariant: Color(0xFF43474E),
    onSurfaceVariant: Color(0xFFC3C6CF),
    outline: Color(0xFF8D9199),
    outlineVariant: Color(0xFF49454F),
  );

  static InputDecorationTheme _darkInputTheme = InputDecorationTheme(
    filled: true,
    isDense: true,
    focusColor: _darkColorScheme.primary,
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    inputDecorationTheme: _darkInputTheme,
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: _darkInputTheme,
    ),
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noThumb,
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      shape: RoundedRectangleBorder(),
      collapsedShape: RoundedRectangleBorder(),
    ),
  );
}
