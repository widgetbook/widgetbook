import 'package:flutter/widgets.dart';

import 'docs.dart';

/// Signature for a function that takes a list of [DocBlock]s and returns a
/// new list of [DocBlock]s.
///
/// Used to customize or transform the documentation blocks shown for a
/// component in Widgetbook.
///
/// See [DocsBlockListExtension] for methods to help manipulate the [docs]
/// list.
typedef DocsBuilderFunction = List<DocBlock> Function(List<DocBlock> docs);

/// Abstract base class for all documentation blocks in Widgetbook.
///
/// Extend this class to create custom blocks that can be rendered in the
/// documentation panel.
abstract class DocBlock extends StatelessWidget {
  const DocBlock({super.key});
}
