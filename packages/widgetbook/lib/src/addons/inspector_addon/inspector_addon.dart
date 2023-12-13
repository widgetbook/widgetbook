import 'package:flutter/material.dart';
import 'package:inspector/inspector.dart';
import '../../fields/fields.dart';
import '../common/common.dart';

class InspectorAddon extends WidgetbookAddon<bool> {
  InspectorAddon({
    this.enabled = false,
  }) : super(
          name: 'Inspector',
        );

  final bool enabled;

  @override
  List<Field> get fields => [
        BooleanField(
          name: 'isEnabled',
          initialValue: enabled,
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
    return Inspector(
              isEnabled: setting,
              child: child,
            );
  }
}
