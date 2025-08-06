import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../fields/fields.dart';
import '../common/common.dart';
import 'minimal_semantics_debugger.dart';

/// A [WidgetbookAddon] that provides a minimal semantics debugger.
///
/// This addon wraps the widget in a [Semantics] widget with a custom
/// [MinimalSemanticsDebugger]. It allows you to visualize the semantics
/// tree of the widget being debugged.
///
/// Learn more: https://docs.widgetbook.io/addons/semantics-addon
@experimental
class SemanticsAddon extends WidgetbookAddon<bool> {
  /// Creates a new instance of [SemanticsAddon].
  SemanticsAddon({
    this.enabled = false,
  }) : super(
         name: 'Semantics',
       );

  /// Whether the semantics debugger is enabled.
  final bool enabled;

  @override
  List<Field> get fields => [
    BooleanField(
      name: 'enabled',
      initialValue: enabled,
    ),
  ];

  @override
  bool valueFromQueryGroup(Map<String, String> group) {
    return valueOf('enabled', group) ?? false;
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
      container: true, // prevent node from getting merged
      explicitChildNodes: true, // prevent children from altering the root node
      child: MinimalSemanticsDebugger(
        rootIdentifier: identifier,
        child: child,
      ),
    );
  }
}
