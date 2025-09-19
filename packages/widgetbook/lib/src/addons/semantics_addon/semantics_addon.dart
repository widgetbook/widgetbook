import 'package:flutter/widgets.dart';

import '../../core/core.dart';
import '../../fields/fields.dart';
import 'minimal_semantics_debugger.dart';

class SemanticsMode extends Mode<bool> {
  SemanticsMode(bool value) : super(value, SemanticsAddon());
}

/// An [Addon] for semantics.
class SemanticsAddon extends Addon<bool> {
  SemanticsAddon() : super(name: 'Semantics');

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

  @override
  Map<String, String> valueToQueryGroup(bool value) {
    return {'enabled': paramOf('enabled', value)};
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child, bool setting) {
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
