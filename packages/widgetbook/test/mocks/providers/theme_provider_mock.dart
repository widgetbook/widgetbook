import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';

class ThemeProviderMock extends Mock implements ThemeProvider {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return super.toString();
  }
}
