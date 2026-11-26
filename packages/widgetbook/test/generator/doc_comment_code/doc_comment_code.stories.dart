import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'doc_comment_code.stories.g.dart';

/// Tests that doc comments containing code with $ interpolation are correctly
/// escaped in the generated output.
const description =
    r'generates correct docComment for doc comments with code containing $ signs';

/// Displays a [label].
///
/// ```dart
/// DocCommentCodeWidget(label: '$name ($age)')
/// ```
class DocCommentCodeWidget extends StatelessWidget {
  const DocCommentCodeWidget({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) => Text(label);
}

const meta = Meta(DocCommentCodeWidget.new);

final $Default = _Story();
