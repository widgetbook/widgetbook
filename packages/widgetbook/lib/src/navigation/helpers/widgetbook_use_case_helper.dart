import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class WidgetbookUseCaseHelper {
  static List<WidgetbookUseCase> fromNodes(
    List<MultiChildNavigationNodeData> nodes,
  ) {
    final useCases = <WidgetbookUseCase>[];
    for (final node in nodes) {
      if (node is WidgetbookComponent) {
        useCases.addAll(node.useCases);
      } else {
        final children = node.children;
        if (children is List<MultiChildNavigationNodeData> && children.isNotEmpty) {
          useCases.addAll(fromNodes(children));
        }
      }
    }
    return useCases;
  }
}
