import 'package:flutter/widgets.dart';

import '../../core/addon.dart';
import '../../core/mode.dart';
import '../../core/mode_addon.dart';
import '../../fields/fields.dart';
import 'minimal_semantics_debugger.dart';

class SemanticsMode extends Mode<bool> {
  SemanticsMode(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    if (!value) return child;

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

/// An [Addon] for semantics.
class SemanticsAddon extends ModeAddon<bool> {
  SemanticsAddon()
    : super(
        name: 'Semantics',
        modeBuilder: SemanticsMode.new,
      );

  @override
  List<Field> get fields {
    return [
      BooleanField(
        name: 'enabled',
        initialValue: false,
      ),
    ];
  }

  @override
  bool valueFromQueryGroup(Map<String, String> group) {
    return valueOf('enabled', group) ?? false;
  }
}
