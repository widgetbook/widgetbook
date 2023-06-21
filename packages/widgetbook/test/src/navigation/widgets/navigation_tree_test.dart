import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import '../../../helper/callback_mock.dart';
import '../../../helper/widget_test_helper.dart';

void main() {
  group(
    '$NavigationTree',
    () {
      const directories = [
        MultiChildNavigationNodeData(
          name: 'Component',
          type: NavigationNodeType.component,
          children: [
            MultiChildNavigationNodeData(
              name: 'Use Case 1',
              type: NavigationNodeType.useCase,
              children: [],
            ),
          ],
        ),
        MultiChildNavigationNodeData(
          name: 'Category',
          type: NavigationNodeType.category,
          children: [],
        ),
      ];

      testWidgets(
        'selectedNode gets updated when a node is tapped',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            const NavigationTree(
              directories: directories,
            ),
          );

          const node = NavigationTreeNodeData(
            path: 'component/use-case-1',
            name: 'Use Case 1',
            type: NavigationNodeType.useCase,
          );

          await tester.tap(
            find.byWidgetPredicate(
              (widget) =>
                  widget is NavigationTreeItem && widget.data.name == node.name,
            ),
          );

          final state = tester.state<NavigationTreeState>(
            find.byType(NavigationTree),
          );

          expect(state.selectedNode?.name, node.name);
        },
      );

      testWidgets(
        'Calls onNodeSelected when a node is tapped',
        (tester) async {
          final callbackMock = OnNodeSelectedCallbackMock<String, dynamic>();

          await tester.pumpWidgetWithMaterialApp(
            NavigationTree(
              directories: directories,
              onNodeSelected: callbackMock.call,
            ),
          );

          const node = NavigationTreeNodeData(
            path: 'component/use-case-1',
            name: 'Use Case 1',
            type: NavigationNodeType.useCase,
          );

          await tester.tap(
            find.byWidgetPredicate(
              (widget) =>
                  widget is NavigationTreeItem && widget.data.name == node.name,
            ),
          );

          verify(
            () => callbackMock(node.path, node.data),
          ).called(1);
        },
      );
    },
  );
}
