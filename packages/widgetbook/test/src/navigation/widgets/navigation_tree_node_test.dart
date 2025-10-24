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
      final leafComponentsCount =
          treeRoot
              .findAll(
                (node) =>
                    node is WidgetbookComponent && node.useCases.length == 1,
              )
              .length;

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
            findsNWidgets(
              // Leaf components don't have a list view rendered for them
              treeRoot.count - treeRoot.leaves.length - leafComponentsCount,
            ),
          );
        },
      );

      testWidgets(
        'given a root node with enableLeafComponents = false , '
        'then the correct number of list views are created',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeNode(
              node: treeRoot,
              enableLeafComponents: false,
            ),
          );

          expect(
            find.byType(ListView),
            findsNWidgets(
              treeRoot.count - treeRoot.leaves.length,
            ),
          );
        },
      );

      testWidgets(
        'given a $WidgetbookComponent node with single use-case, '
        'when its use-case is selected, '
        'then the node is selected',
        (tester) async {
          final leaf = WidgetbookComponent(
            name: 'Leaf',
            useCases: [
              WidgetbookUseCase(
                name: 'UseCase',
                builder: (context) => Container(),
              ),
            ],
          );

          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeNode(
              selectedNode: leaf.useCases.first,
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
        'given a $WidgetbookComponent node with single use-case '
        'with a enabledLeafComponents = false, '
        'when its use-case is selected, '
        'then the node is not selected',
        (tester) async {
          final leaf = WidgetbookComponent(
            name: 'Leaf',
            useCases: [
              WidgetbookUseCase(
                name: 'UseCase',
                builder: (context) => Container(),
              ),
            ],
          );

          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeNode(
              selectedNode: leaf.useCases.first,
              node: leaf,
              enableLeafComponents: false,
            ),
          );

          final tiles = find.byType(NavigationTreeTile);

          expect(tiles, findsNWidgets(2));
          final tile = await tester.widget<NavigationTreeTile>(
            find.byType(NavigationTreeTile).first,
          );
          final tileChild = await tester.widget<NavigationTreeTile>(
            find.byType(NavigationTreeTile).last,
          );

          expect(
            tile.isSelected,
            equals(false),
          );
          expect(
            tileChild.isSelected,
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
        'when a $WidgetbookComponent with a single child is tapped, '
        'then the onNodeSelected callback is called with the child use-case',
        (tester) async {
          final useCase = WidgetbookUseCase(
            name: 'UseCase Node',
            builder: (context) => Container(),
          );

          final onValueChanged = VoidFn1Mock<WidgetbookNode>();

          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeNode(
              node: WidgetbookComponent(
                name: 'Leaf',
                useCases: [useCase],
              ),
              onNodeSelected: onValueChanged.call,
            ),
          );

          await tester.tap(find.byType(NavigationTreeTile).first);

          verify(() => onValueChanged.call(useCase)).called(1);
        },
      );

      testWidgets(
        'when a $WidgetbookComponent with a single child is tapped '
        'and enableLeafComponents = false, '
        'then the onNodeSelected callback is called with the child use-case',
        (tester) async {
          final useCase = WidgetbookUseCase(
            name: 'UseCase Node',
            builder: (context) => Container(),
          );

          final onValueChanged = VoidFn1Mock<WidgetbookNode>();

          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeNode(
              node: WidgetbookComponent(
                name: 'Leaf',
                useCases: [useCase],
              ),
              onNodeSelected: onValueChanged.call,
              enableLeafComponents: false,
            ),
          );

          await tester.tap(find.byType(NavigationTreeTile).last);

          verify(() => onValueChanged.call(useCase)).called(1);
        },
      );
    },
  );
}
