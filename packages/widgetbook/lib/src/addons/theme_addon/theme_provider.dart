import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class ThemeProvider<T> extends ValueNotifier<WidgetbookTheme<T>> {
  ThemeProvider(WidgetbookTheme<T> data) : super(data);
}
