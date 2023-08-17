import 'package:meta/meta.dart';

import 'widgetbook_node.dart';
import 'widgetbook_use_case.dart';

/// The root of all [WidgetbookNode]s.
class WidgetbookRoot extends WidgetbookNode {
  WidgetbookRoot({
    required super.children,
  }) : super(
          name: '',
          isInitiallyExpanded: true,
        ) {
    table = Map.fromEntries(
      leaves
          .whereType<WidgetbookUseCase>()
          .map((node) => MapEntry(node.path, node)),
    );
  }

  /// A table of all [WidgetbookUseCase]s and their paths.
  @internal
  late final Map<String, WidgetbookUseCase> table;

  @override
  WidgetbookRoot copyWith({
    String? name,
    List<WidgetbookNode>? children,
  }) {
    return WidgetbookRoot(
      children: children ?? this.children,
    );
  }
}
