import 'package:flutter/material.dart';

import 'docs.dart';

/// A [DocBlock] that displays a title in the documentation panel.
///
/// Used to provide a main heading for components or documentation sections.
class TitleBlock extends DocBlock {
  const TitleBlock({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
