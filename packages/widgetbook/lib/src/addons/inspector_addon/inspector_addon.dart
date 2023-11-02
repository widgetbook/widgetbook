import 'package:flutter/material.dart';
import 'package:inspector/inspector.dart';
import '../../fields/fields.dart';
import '../common/common.dart';

class InspectorAddon extends WidgetbookAddon<bool> {
  InspectorAddon({bool enabled = false})
      : super(
          name: 'Inspector',
          initialSetting: enabled,
        );

  @override
  List<Field> get fields => [
        BooleanField(
          name: 'isEnabled',
          initialValue: initialSetting,
        ),
      ];

  @override
  bool valueFromQueryGroup(Map<String, String> group) {
    return valueOf('isEnabled', group) ?? false;
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    bool setting,
  ) {
    return setting
        ? Scaffold(
            backgroundColor: const Color(0xFF121515),
            body: Inspector(child: child),
          )
        : child;
  }
}
