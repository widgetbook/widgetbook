import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// A widget that provides the themed used in the [Widgetbook] app.
@internal
class InheritedWidgetbookTheme extends InheritedWidget {
  /// A widget that provides the themed used in the [Widgetbook] app.
  const InheritedWidgetbookTheme({
    required super.child,
    required this.theme,
    super.key,
  });

  /// The theme to provides.
  final ThemeData theme;

  /// The data from the closest [InheritedWidgetbookTheme] instance that
  /// encloses the given context, if any.
  static ThemeData? maybeOf(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<InheritedWidgetbookTheme>();
    return widget?.theme;
  }

  @override
  bool updateShouldNotify(InheritedWidgetbookTheme oldWidget) {
    return theme != oldWidget.theme;
  }
}
