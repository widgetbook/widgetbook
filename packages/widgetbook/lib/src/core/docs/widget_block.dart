import 'package:flutter/widgets.dart';

import 'docs.dart';

/// A [DocBlock] that displays a custom widget in the documentation.
class WidgetDocBlock extends DocBlock {
  const WidgetDocBlock(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
