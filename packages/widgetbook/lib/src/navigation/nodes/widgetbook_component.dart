import 'tree_node.dart';
import 'widgetbook_use_case.dart';

class WidgetbookComponent extends TreeNode {
  WidgetbookComponent({
    required super.name,
    required this.useCases,
    this.isInitiallyExpanded = true,
  }) : super(
          children: useCases,
        );

  final List<WidgetbookUseCase> useCases;
  final bool isInitiallyExpanded;
}
