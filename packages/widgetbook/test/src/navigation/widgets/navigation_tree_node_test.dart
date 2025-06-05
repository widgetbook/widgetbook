import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import '../../../helper/helper.dart';
import '../tree_root.dart';

void main() {
  group(
    '$NavigationTreeNode',
    () {
      testWidgets(
        'given a root node, '
        'then the correct number of list views are created',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeNode(
              node: treeRoot,
            ),
          );

          expect(
            find.byType(ListView),
            findsNWidgets(treeRoot.count - treeRoot.leaves.length),
          );
        },
      );

      testWidgets(
        'given a $WidgetbookLeafComponent node, '
        'when its use-case is selected, '
        'then the node is selected',
        (tester) async {
          final leaf = WidgetbookLeafComponent(
            name: 'Leaf',
            useCase: WidgetbookUseCase(
              name: 'UseCase',
              builder: (context) => Container(),
            ),
          );

          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeNode(
              selectedPath: leaf.useCase.path,
              node: leaf,
            ),
          );

          final tile = await tester.widget<NavigationTreeTile>(
            find.byType(NavigationTreeTile),
          );

          expect(
            tile.isSelected,
            equals(true),
          );
        },
      );

      testWidgets(
        'when a node is tapped, '
        'then the onNodeSelected callback is called',
        (tester) async {
          final node = WidgetbookUseCase(
            name: 'UseCase Node',
            builder: (context) => Container(),
          );

          final onValueChanged = VoidFn1Mock<WidgetbookNode>();

          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeNode(
              node: node,
              onNodeSelected: onValueChanged.call,
            ),
          );

          await tester.tap(find.byType(NavigationTreeTile).first);

          verify(() => onValueChanged.call(node)).called(1);
        },
      );

      testWidgets(
        'when a $WidgetbookLeafComponent is tapped, '
        'then the onNodeSelected callback is called with the child use-case',
        (tester) async {
          final useCase = WidgetbookUseCase(
            name: 'UseCase Node',
            builder: (context) => Container(),
          );

          final onValueChanged = VoidFn1Mock<WidgetbookNode>();

          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeNode(
              node: WidgetbookLeafComponent(
                name: 'Leaf',
                useCase: useCase,
              ),
              onNodeSelected: onValueChanged.call,
            ),
          );

          await tester.tap(find.byType(NavigationTreeTile).first);

          verify(() => onValueChanged.call(useCase)).called(1);
        },
      );
    },
  );
}
