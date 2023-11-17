import 'package:flutter/material.dart';

import '../navigation/nodes/nodes.dart';
import 'widgetbook_args.dart';

@optionalTypeArgs
class WidgetbookStory<TWidget, TArgs extends WidgetbookArgs<TWidget, TArgs>>
    extends WidgetbookUseCase {
  WidgetbookStory({
    required super.name,
    required this.args,
    super.designLink,
  }) : super(
          builder: (context) => args.build(context),
        );

  final TArgs args;

  @override
  WidgetbookStory<dynamic, WidgetbookArgs<dynamic, dynamic>> copyWith({
    String? name,
    List<WidgetbookNode>? children,
  }) {
    return this;
  }
}
