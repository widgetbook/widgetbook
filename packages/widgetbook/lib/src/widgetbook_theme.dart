import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// A widget that provides the theme used in the [Widgetbook] app.
@internal
class WidgetbookTheme extends InheritedWidget {
  /// A widget that provides the theme used in the [Widgetbook] app.
  const WidgetbookTheme({
    required super.child,
    required this.data,
    super.key,
  });

  /// The theme to provide.
  final ThemeData data;

  /// The data from the closest [WidgetbookTheme] instance that
  /// encloses the given context, if any.
  static ThemeData? maybeOf(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<WidgetbookTheme>();
    return widget?.data;
  }

  /// The data from the closest [WidgetbookTheme] instance that
  /// encloses the given context.
  static ThemeData of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<WidgetbookTheme>();
    assert(result != null, 'No WidgetbookTheme found in context');
    return result!.data;
  }

  @override
  bool updateShouldNotify(WidgetbookTheme oldWidget) {
    return data != oldWidget.data;
  }
}
