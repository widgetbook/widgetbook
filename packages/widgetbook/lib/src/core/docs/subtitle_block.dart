import 'package:flutter/material.dart';

import 'docs.dart';

/// A [DocBlock] that displays text in subtitle styling in the documentation
/// panel.
///
/// Used to provide section headings for stories or other documentation blocks.
class SubtitleDocBlock extends DocBlock {
  const SubtitleDocBlock({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
