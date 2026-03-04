import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'doc_comment_code.stories.g.dart';

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

const meta = Meta<DocCommentCodeWidget>();

final $Default = Object();
