import 'package:flutter/material.dart';

import '../../../widgetbook.dart';

/// A [DocBlock] that displays the name of the current [Component] in the
/// documentation panel.
///
/// Used to provide a title for the documentation page.
class ComponentNameBlock extends DocBlock {
  const ComponentNameBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    return TitleBlock(title: state.component!.name);
  }
}
