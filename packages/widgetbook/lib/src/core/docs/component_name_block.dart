import 'package:flutter/material.dart';

import '../framework/component.dart';
import '../state/state.dart';
import 'docs.dart';

/// A [DocBlock] that displays the name of the current [Component] in the
/// documentation panel.
///
/// Used to provide a title for the documentation page.
class ComponentNameDocBlock extends DocBlock {
  const ComponentNameDocBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    return TitleDocBlock(title: state.component!.name);
  }
}
