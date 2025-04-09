import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../fields/fields.dart';
import '../common/common.dart';
import 'minimal_semantics_debugger.dart';

@experimental
class SemanticsAddon extends WidgetbookAddon<bool> {
  SemanticsAddon({
    this.enabled = false,
  }) : super(
          name: 'Semantics',
        );

  final bool enabled;

  @override
  List<Field> get fields => [
        BooleanField(
          name: 'Enabled',
          initialValue: enabled,
        ),
      ];

  @override
  bool valueFromQueryGroup(Map<String, String> group) {
    return valueOf('Enabled', group) ?? false;
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    bool setting,
  ) {
    if (!setting) return child;

    const identifier = 'SemanticsAddon.Root';

    return Semantics(
      // This semantics node will be used as the root of the semantics tree
      // for the widget being debugged.
      identifier: identifier,
      child: MinimalSemanticsDebugger(
        rootIdentifier: identifier,
        child: child,
      ),
    );
  }
}
