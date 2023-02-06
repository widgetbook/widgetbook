import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../helper/bloc_mocks.dart';
import '../../../helper/callback_mock.dart';
import '../../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$NavigationTree',
    () {
      const nodes = [
        NavigationTreeNodeData(
          path: 'component',
          name: 'Component',
          type: NavigationNodeType.component,
          children: [
            NavigationTreeNodeData(
              path: 'component/use-case-1',
              name: 'Use Case 1',
              type: NavigationNodeType.useCase,
            ),
          ],
        ),
        NavigationTreeNodeData(
          path: 'category',
          name: 'Category',
          type: NavigationNodeType.category,
          children: [],
        ),
      ];

      late NavigationBloc navigationBloc;
      setUp(() {
        navigationBloc = MockNavigationBloc();
      });

      testWidgets(
        'Triggers $SelectNavigationNodeByPath when initialPath is provided',
        (WidgetTester tester) async {
          when(() => navigationBloc.state).thenReturn(
            NavigationState(
              nodes: nodes,
              filteredNodes: nodes,
            ),
          );

          const nodePath = 'component/use-case-1';

          await tester.pumpWidgetWithMaterial(
            child: BlocProvider.value(
              value: navigationBloc,
              child: const NavigationTree(
                initialPath: nodePath,
              ),
            ),
          );
          await tester.pumpAndSettle();
          verify(
            () => navigationBloc.add(
              const SelectNavigationNodeByPath(path: nodePath),
            ),
          ).called(1);
        },
      );

      testWidgets(
        'Renders navigation tree nodes',
        (WidgetTester tester) async {
          when(() => navigationBloc.state).thenReturn(
            NavigationState(
              nodes: nodes,
              filteredNodes: nodes,
            ),
          );

          await tester.pumpWidgetWithMaterial(
            child: BlocProvider.value(
              value: navigationBloc,
              child: const NavigationTree(),
            ),
          );

          await tester.pumpAndSettle();

          for (final node in nodes) {
            final nodeFinder = find.byWidgetPredicate(
              (Widget widget) =>
                  widget is NavigationTreeItem && widget.data == node,
            );

            expect(nodeFinder, findsOneWidget);
          }
        },
      );

      testWidgets(
        'Triggers $SelectNavigationNode when a node is tapped',
        (WidgetTester tester) async {
          when(() => navigationBloc.state).thenReturn(
            NavigationState(
              nodes: nodes,
              filteredNodes: nodes,
            ),
          );

          const node = NavigationTreeNodeData(
            path: 'component/use-case-1',
            name: 'Use Case 1',
            type: NavigationNodeType.useCase,
          );

          await tester.pumpWidgetWithMaterial(
            child: BlocProvider.value(
              value: navigationBloc,
              child: const NavigationTree(),
            ),
          );
          await tester.pumpAndSettle();
          final nodeFinder = find.byWidgetPredicate(
            (Widget widget) =>
                widget is NavigationTreeItem && widget.data == node,
          );

          await tester.tap(nodeFinder);

          verify(
            () => navigationBloc.add(
              const SelectNavigationNode(node: node),
            ),
          ).called(1);
        },
      );

      testWidgets(
        'Calls onNodeSelected when a node is tapped',
        (WidgetTester tester) async {
          when(() => navigationBloc.state).thenReturn(
            NavigationState(
              nodes: nodes,
              filteredNodes: nodes,
            ),
          );

          final onNodeSelectedCallbackMock =
              OnNodeSelectedCallbackMock<String, dynamic>();

          const node = NavigationTreeNodeData(
            path: 'component/use-case-1',
            name: 'Use Case 1',
            type: NavigationNodeType.useCase,
          );

          await tester.pumpWidgetWithMaterial(
            child: BlocProvider.value(
              value: navigationBloc,
              child: NavigationTree(
                onNodeSelected: onNodeSelectedCallbackMock,
              ),
            ),
          );
          await tester.pumpAndSettle();
          final nodeFinder = find.byWidgetPredicate(
            (Widget widget) =>
                widget is NavigationTreeItem && widget.data == node,
          );

          await tester.tap(nodeFinder);

          verify(
            () => onNodeSelectedCallbackMock(node.path, node.data),
          ).called(1);
        },
      );
    },
  );
}
