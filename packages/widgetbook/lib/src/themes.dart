import 'package:flutter/material.dart';

/// Contains the style definition of Widgetbook.
class Themes {
  static const _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFA1C9FF),
    onPrimary: Color(0xFF00325A),
    primaryContainer: Color(0xFF004880),
    onPrimaryContainer: Color(0xFFD2E4FF),
    secondary: Color(0xFFBBC7DB),
    onSecondary: Color(0xFF263141),
    secondaryContainer: Color(0xFF3C4858),
    onSecondaryContainer: Color(0xFFD7E3F8),
    tertiary: Color(0xFFD8BDE4),
    onTertiary: Color(0xFF3C2947),
    tertiaryContainer: Color(0xFF533F5F),
    onTertiaryContainer: Color(0xFFF4D9FF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF1A1C1E),
    onSurface: Color(0xFFE3E2E6),
    onSurfaceVariant: Color(0xFFC3C6CF),
    outline: Color(0xFF8D9199),
    onInverseSurface: Color(0xFF1A1C1E),
    inverseSurface: Color(0xFFE3E2E6),
    inversePrimary: Color(0xFF0060A7),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFA1C9FF),

    // The following parameters are deprecated in Flutter 3.22.0,
    // But we cannot remove them because our minimum version is 3.19.0,
    // and these parameters are required there.

    // ignore: deprecated_member_use
    background: Color(0xFF1A1C1E),
    // ignore: deprecated_member_use
    onBackground: Color(0xFFE3E2E6),
    // ignore: deprecated_member_use
    surfaceVariant: Color(0xFF43474E),
  );

  static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0060A7),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD2E4FF),
    onPrimaryContainer: Color(0xFF001C37),
    secondary: Color(0xFF4E6078),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD2E4FF),
    onSecondaryContainer: Color(0xFF081C32),
    tertiary: Color(0xFF705382),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFF4D9FF),
    onTertiaryContainer: Color(0xFF290F3A),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    surface: Color(0xFFFDFCFF),
    onSurface: Color(0xFF1A1C1E),
    onSurfaceVariant: Color(0xFF43474E),
    outline: Color(0xFF73777F),
    onInverseSurface: Color(0xFFE3E2E6),
    inverseSurface: Color(0xFF1A1C1E),
    inversePrimary: Color(0xFFA1C9FF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF0060A7),

    // The following parameters are deprecated in Flutter 3.22.0,
    // But we cannot remove them because our minimum version is 3.19.0,
    // and these parameters are required there.

    // ignore: deprecated_member_use
    background: Color(0xFFFDFCFF),
    // ignore: deprecated_member_use
    onBackground: Color(0xFF1A1C1E),
    // ignore: deprecated_member_use
    surfaceVariant: Color(0xFFDFE2EB),
  );

  static InputDecorationTheme _buildInputTheme(
    ColorScheme colorScheme,
  ) {
    return InputDecorationTheme(
      filled: true,
      isDense: true,
      // By default, this is [ColorScheme.surfaceContainerHighest], but we
      // need to override it to [ColorScheme.surfaceVariant] due to the minimum
      // Flutter version being 3.19.0, which does not have the new parameter.
      // ignore: deprecated_member_use
      fillColor: colorScheme.surfaceVariant,
      // Match TextField and DropdownMenu heights
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 12.0,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.primary,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
    );
  }

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    colorScheme: _darkColorScheme,
    hoverColor: const Color(0xFFE3E2E6).withAlpha(20),
    tabBarTheme: TabBarTheme(
      dividerColor: _darkColorScheme.outline,
    ),
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noThumb,
      // By default, this is [ColorScheme.surfaceContainerHighest], but we
      // need to override it to [ColorScheme.surfaceVariant] due to the minimum
      // Flutter version being 3.19.0, which does not have the new parameter.
      // ignore: deprecated_member_use
      inactiveTrackColor: _darkColorScheme.surfaceVariant,
    ),
    inputDecorationTheme: _buildInputTheme(_darkColorScheme),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: _buildInputTheme(_darkColorScheme),
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      collapsedShape: RoundedRectangleBorder(),
      shape: RoundedRectangleBorder(),
    ),
  );

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    colorScheme: _lightColorScheme,
    hoverColor: const Color(0xFF1A1C1E).withAlpha(20),
    tabBarTheme: TabBarTheme(
      dividerColor: _darkColorScheme.outline,
    ),
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noThumb,
      // By default, this is [ColorScheme.surfaceContainerHighest], but we
      // need to override it to [ColorScheme.surfaceVariant] due to the minimum
      // Flutter version being 3.19.0, which does not have the new parameter.
      // ignore: deprecated_member_use
      inactiveTrackColor: _lightColorScheme.surfaceVariant,
    ),
    inputDecorationTheme: _buildInputTheme(_lightColorScheme),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: _buildInputTheme(_lightColorScheme),
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      collapsedShape: RoundedRectangleBorder(),
      shape: RoundedRectangleBorder(),
    ),
  );
}
