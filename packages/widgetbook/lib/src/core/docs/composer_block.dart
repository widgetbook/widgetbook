import 'package:flutter/widgets.dart';

import 'docs.dart';

/// A [DocBlock] that composes multiple widgets or [DocBlock]s vertically
/// in the documentation panel.
///
/// Used to group and layout other [DocBlock]s.
class ComposerDocBlock extends DocBlock {
  const ComposerDocBlock({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: children,
    );
  }
}
