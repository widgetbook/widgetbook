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
    },
  );
}
