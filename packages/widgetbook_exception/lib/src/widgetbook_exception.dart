// Copyright (c) 2022, Jens Horstmann
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

/// {@template widgetbook_exception}
/// An exception thrown by an internal widgetbook command.
/// {@endtemplate}
class WidgetbookException implements Exception {
  /// {@macro widgetbook_exception}
  const WidgetbookException(this.message);

  /// The error message which will be displayed to the user .
  final String message;

  @override
  String toString() => message;
}
