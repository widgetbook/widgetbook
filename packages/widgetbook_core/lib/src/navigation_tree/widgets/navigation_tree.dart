import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

typedef NodeSelectedCallback = void Function(
  String path,
  dynamic data,
);

class NavigationTree extends StatefulWidget {
  const NavigationTree({
    super.key,
    this.onNodeSelected,
    this.initialPath,
  });

  final NodeSelectedCallback? onNodeSelected;
  final String? initialPath;

  @override
  State<NavigationTree> createState() => _NavigationTreeState();
}

class _NavigationTreeState extends State<NavigationTree> {
  @override
  void initState() {
    if (widget.initialPath != null) {
      context.read<NavigationBloc>().add(
            SelectNavigationNodeByPath(path: widget.initialPath!),
          );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NavigationBloc>().state;
    final nodes = state.filteredNodes;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: nodes.length,
      itemBuilder: (context, index) => NavigationTreeNode(
        data: nodes[index],
        selectedNode: state.selectedNode,
        onNodeSelected: (NavigationTreeNodeData node) {
          context.read<NavigationBloc>().add(
                SelectNavigationNode(node: node),
              );
          widget.onNodeSelected?.call(node.path, node.data);
        },
      ),
    );
  }
}
