import 'package:flutter/widgets.dart';

abstract class BaseLayout {
  const BaseLayout({
    required this.navigation,
    required this.addons,
    required this.knobs,
    required this.workbench,
  });

  final Widget navigation;
  final List<Widget> addons;
  final List<Widget> knobs;
  final Widget workbench;
}
