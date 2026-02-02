import 'package:flutter/material.dart';

import 'docs.dart';

/// A [DocBlock] that displays a block of text in the documentation panel.
class TextDocBlock extends DocBlock {
  const TextDocBlock(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
