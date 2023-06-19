import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import '../../../helper/callback_mock.dart';
import '../../../helper/widget_test_helper.dart';

void main() {
  final nodeWithOneLevelOfChildren = WidgetbookComponent(
    name: 'Component',
    isInitiallyExpanded: false,
    useCases: [
      WidgetbookUseCase(
        name: 'Use Case 1',
        builder: (_) => const SizedBox.shrink(),
      ),
      WidgetbookUseCase(
        name: 'Use Case 2',
        builder: (_) => const SizedBox.shrink(),
      ),
    ],
  );

  group('$NavigationTreeNode', () {
    testWidgets(
      'Can render correct number of first level child node widgets',
      (tester) async {
        await tester.pumpWidgetWithMaterialApp(
          NavigationTreeNode(
            data: nodeWithOneLevelOfChildren,
          ),
        );

        expect(
          find.byType(NavigationTreeNode),
          findsNWidgets(nodeWithOneLevelOfChildren.children!.length + 1),
        );
      },
    );

    testWidgets(
      'Calls onNodeSelected with selected node id',
      (tester) async {
        final useCaseNode = WidgetbookUseCase(
          name: 'Use Case',
          builder: (_) => const SizedBox.shrink(),
        );

        final valueChangedCallbackMock =
            ValueChangedCallbackMock<NavigationEntity>();

        await tester.pumpWidgetWithMaterialApp(
          NavigationTreeNode(
            data: useCaseNode,
            onNodeSelected: valueChangedCallbackMock.call,
          ),
        );

        await tester.tap(find.byType(NavigationTreeItem).first);
        verify(() => valueChangedCallbackMock.call(useCaseNode)).called(1);
      },
    );

    testWidgets(
      'Can expand children ListView',
      (tester) async {
        await tester.pumpWidgetWithMaterialApp(
          NavigationTreeNode(
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
