import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Base class for layouts in Widgetbook.
@internal
abstract class BaseLayout {
  const BaseLayout({
    required this.navigationBuilder,
    required this.addonsBuilder,
    required this.knobsBuilder,
    required this.workbench,
  });

  final Widget Function(BuildContext context) navigationBuilder;
  final List<Widget> Function(BuildContext context) addonsBuilder;
  final List<Widget> Function(BuildContext context) knobsBuilder;
  final Widget workbench;
}
