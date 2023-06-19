import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import '../../../helper/callback_mock.dart';
import '../../../helper/widget_test_helper.dart';

void main() {
  group(
    '$NavigationTree',
    () {
      final directories = [
        WidgetbookComponent(
          name: 'Component',
          useCases: [
            WidgetbookUseCase(
              name: 'Use Case 1',
              builder: (_) => const SizedBox.shrink(),
            ),
          ],
        ),
        WidgetbookCategory(
          name: 'Category',
          children: [],
        ),
      ];

      testWidgets(
        'selectedNode gets updated when a node is tapped',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            NavigationTree(
              directories: directories,
            ),
          );

          final node = WidgetbookUseCase(
            name: 'Use Case 1',
            builder: (_) => const SizedBox.shrink(),
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
          final callbackMock = ValueChangedCallbackMock<NavigationEntity>();

          await tester.pumpWidgetWithMaterialApp(
            NavigationTree(
              directories: directories,
              onNodeSelected: callbackMock.call,
            ),
          );

          final node = WidgetbookUseCase(
            name: 'Use Case 1',
            builder: (_) => const SizedBox.shrink(),
          );

          await tester.tap(
            find.byWidgetPredicate(
              (widget) =>
                  widget is NavigationTreeItem && widget.data.name == node.name,
            ),
          );

          verify(
            () => callbackMock(node),
          ).called(1);
        },
      );
    },
  );
}
