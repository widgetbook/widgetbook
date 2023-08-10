import 'tree_node.dart';
import 'widgetbook_use_case.dart';

class WidgetbookComponent extends TreeNode {
  WidgetbookComponent({
    required super.name,
    required this.useCases,
    super.isInitiallyExpanded,
  }) : super(
          children: useCases,
        );

  final List<WidgetbookUseCase> useCases;

  @override
  WidgetbookComponent copyWith({
    String? name,
    covariant List<WidgetbookUseCase>? children,
  }) {
    return WidgetbookComponent(
      name: name ?? this.name,
      useCases: children ?? this.useCases,
      isInitiallyExpanded: isInitiallyExpanded,
    );
  }
}
