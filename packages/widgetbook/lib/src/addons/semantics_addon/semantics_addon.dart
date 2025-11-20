import 'package:flutter/widgets.dart';

import '../../core/core.dart';
import '../../fields/fields.dart';
import 'minimal_semantics_debugger.dart';

class SemanticsMode extends Mode<bool> {
  SemanticsMode(bool value) : super(value, SemanticsAddon());
}

/// An [Addon] for semantics.
class SemanticsAddon extends Addon<bool> with SingleFieldOnly {
  SemanticsAddon()
    : super(
        name: 'Semantics',
        initialValue: false,
      );

  @override
  Field<bool> get field {
    return BooleanField(
      name: 'enabled',
      initialValue: initialValue,
    );
  }

  @override
  Widget apply(BuildContext context, Widget child, bool setting) {
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
