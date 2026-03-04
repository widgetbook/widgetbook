import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'doc_comment.stories.g.dart';

/// A widget with documentation.
///
/// This has an empty line above.
class DocCommentWidget extends StatelessWidget {
  const DocCommentWidget({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) => Text(label);
}

const meta = Meta<DocCommentWidget>();

final $Default = Object();
