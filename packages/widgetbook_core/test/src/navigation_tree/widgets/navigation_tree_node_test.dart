import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../helper/callback_mock.dart';
import '../../../helper/widget_tester_extension.dart';

void main() {
  const nodeWithOneLevelOfChildren = NavigationTreeNodeData(
    path: 'component/',
    name: 'Component',
    type: NavigationNodeType.component,
    isInitiallyExpanded: false,
    children: [
      NavigationTreeNodeData(
        path: 'component/use_case_1_id',
        name: 'Use Case 1',
        type: NavigationNodeType.useCase,
      ),
      NavigationTreeNodeData(
        path: 'component/use_case_2_id',
        name: 'Use Case 2',
        type: NavigationNodeType.useCase,
      ),
    ],
  );

  group('$NavigationTreeNode', () {
    testWidgets(
      'Can render correct number of first level child node widgets',
      (WidgetTester tester) async {
        await tester.pumpWidgetWithMaterial(
          child: const NavigationTreeNode(
            data: nodeWithOneLevelOfChildren,
          ),
        );

        expect(
          find.byType(NavigationTreeNode),
          findsNWidgets(nodeWithOneLevelOfChildren.children.length + 1),
        );
      },
    );

    testWidgets(
      'Calls onNodeSelected with selected node id',
      (WidgetTester tester) async {
        const useCaseNode = NavigationTreeNodeData(
          path: 'use_case_id',
          name: 'Use Case',
          type: NavigationNodeType.useCase,
        );

        final valueChangedCallbackMock =
            ValueChangedCallbackMock<NavigationTreeNodeData>();
        await tester.pumpWidgetWithMaterial(
          child: NavigationTreeNode(
            data: useCaseNode,
            onNodeSelected: valueChangedCallbackMock,
          ),
        );

        await tester.tap(find.byType(NavigationTreeItem).first);
        verify(() => valueChangedCallbackMock.call(useCaseNode)).called(1);
      },
    );

    testWidgets(
      'Can expand children ListView',
      (WidgetTester tester) async {
        await tester.pumpWidgetWithMaterial(
          child: const NavigationTreeNode(
            data: nodeWithOneLevelOfChildren,
          ),
        );

        expect(
          find.byType(ListView).hitTestable(),
          findsNothing,
        );

        await tester.tap(find.byType(NavigationTreeItem).first);
        await tester.pumpAndSettle();

        expect(
          find.byType(ListView).hitTestable(),
          findsOneWidget,
        );
      },
    );
  });
}
