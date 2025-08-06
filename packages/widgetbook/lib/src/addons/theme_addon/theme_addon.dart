import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';
import 'addon.dart';

/// Function signature for building themed widgets.
typedef ThemeBuilder<T> =
    Widget Function(
      BuildContext context,
      T theme,
      Widget child,
    );

/// A [WidgetbookAddon] for switching between different custom theme
/// configurations.
///
/// [ThemeAddon] allows users to switch between predefined theme configurations
/// in the Widgetbook interface. This is useful for testing widgets with different
/// design system themes, custom branding, or any themed configuration.
///
/// Unlike [MaterialThemeAddon] and [CupertinoThemeAddon] which work with
/// framework-specific themes, [ThemeAddon] is generic and can work with any
/// custom theme system.
///
/// Learn more: https://docs.widgetbook.io/addons/theme-addon#custom-theme
class ThemeAddon<T> extends WidgetbookAddon<WidgetbookTheme<T>> {
  /// Creates a new instance of [ThemeAddon].
  ThemeAddon({
    required this.themes,
    this.initialTheme,
    required this.themeBuilder,
  }) : assert(
         themes.isNotEmpty,
         'themes cannot be empty',
       ),
       assert(
         initialTheme == null || themes.contains(initialTheme),
         'initialTheme must be in themes',
       ),
       super(
         name: 'Theme',
       );

  /// Initial theme to display when the addon loads.
  final WidgetbookTheme<T>? initialTheme;

  /// A list of available themes.
  final List<WidgetbookTheme<T>> themes;

  /// A function that builds the themed widget.
  final ThemeBuilder<T> themeBuilder;

  @override
  List<Field> get fields {
    return [
      ObjectDropdownField<WidgetbookTheme<T>>(
        name: 'name',
        values: themes,
        initialValue: initialTheme ?? themes.first,
        labelBuilder: (theme) => theme.name,
      ),
    ];
  }

  @override
  WidgetbookTheme<T> valueFromQueryGroup(Map<String, String> group) {
    return valueOf('name', group)!;
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    WidgetbookTheme<T> setting,
  ) {
    return themeBuilder(
      context,
      setting.data,
      child,
    );
  }
}
