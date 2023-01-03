import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';
import 'package:widgetbook_for_widgetbook/navigation/navigation_test_data.dart';

@WidgetbookUseCase(name: 'Default', type: NavigationTree)
Widget navigationTreeDefaultUseCase(BuildContext context) {
  return const NavigationTreeWrapper();
}

class NavigationTreeWrapper extends StatefulWidget {
  const NavigationTreeWrapper({super.key});

  @override
  State<NavigationTreeWrapper> createState() => _NavigationTreeWrapperState();
}

class _NavigationTreeWrapperState extends State<NavigationTreeWrapper> {
  NavigationTreeNodeData? selectedNode;

  @override
  Widget build(BuildContext context) {
    return NavigationTree(
      nodes: testTree,
      selectedNode: selectedNode,
      onNodeSelected: (node) {
        setState(() {
          selectedNode = node;
        });
      },
    );
  }
}
