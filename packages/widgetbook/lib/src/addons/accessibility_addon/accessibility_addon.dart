import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for inspecting a. It's based on the
/// [`accessibility_tools`](https://pub.dev/packages/accessibility_tools)
/// package.
class AccessibilityAddon extends WidgetbookAddon<void> {
  AccessibilityAddon()
      : super(
          name: 'Accessibility',
        );

  @override
  List<Field> get fields => [];

  @override
  void valueFromQueryGroup(Map<String, String> group) {}

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    void setting,
  ) {
    return AccessibilityTools(
      child: child,
    );
  }
}
