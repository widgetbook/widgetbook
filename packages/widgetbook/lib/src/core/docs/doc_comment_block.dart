import 'package:flutter/widgets.dart';

import '../framework/component.dart';
import '../state/state.dart';
import 'docs.dart';

/// A [DocBlock] that displays the documentation comments for the current
/// [Component].
///
/// Documentation comments are extracted from the source code when running the
/// build_runner.
class DocCommentBlock extends DocBlock {
  const DocCommentBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final component = state.component;

    return TextDocBlock(
      component!.docComment ?? 'No documentation available.',
    );
  }
}
