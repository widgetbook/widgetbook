import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../helper/callback_mock.dart';
import '../../../helper/widget_tester_extension.dart';

void main() {
  group('$NavigationTree', () {
    testWidgets(
      'Calls onNodeSelected with selected node id',
      (WidgetTester tester) async {
        const testTree = [
          NavigationTreeNodeData(
            id: 'use_case_id_1',
            name: 'Use Case',
            type: NavigationNodeType.useCase,
          ),
          NavigationTreeNodeData(
            id: 'use_case_id_2',
            name: 'Use Case',
            type: NavigationNodeType.useCase,
          ),
        ];

        final valueChangedCallbackMock =
            ValueChangedCallbackMock<NavigationTreeNodeData>();
        await tester.pumpWidgetWithMaterial(
          child: NavigationTree(
            nodes: testTree,
            onNodeSelected: valueChangedCallbackMock,
          ),
        );

        final useCaseFinder = find.byWidgetPredicate(
          (Widget widget) =>
              widget is NavigationTreeItem && widget.data.id == testTree[1].id,
        );
        await tester.tap(useCaseFinder);
        verify(() => valueChangedCallbackMock.call(testTree[1])).called(1);
      },
    );
  });
}
