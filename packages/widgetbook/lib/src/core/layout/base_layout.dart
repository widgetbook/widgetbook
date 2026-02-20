import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Base class for layouts in Widgetbook.
@internal
abstract class BaseLayout {
  const BaseLayout({
    required this.navigationBuilder,
    required this.addonsBuilder,
    required this.argsBuilder,
    required this.scenarioInfoBuilder,
    required this.workbench,
  });

  final Widget Function(BuildContext context) navigationBuilder;
  final List<Widget> Function(BuildContext context) addonsBuilder;
  final List<Widget> Function(BuildContext context) argsBuilder;
  final Widget Function(BuildContext context) scenarioInfoBuilder;
  final Widget workbench;
}
