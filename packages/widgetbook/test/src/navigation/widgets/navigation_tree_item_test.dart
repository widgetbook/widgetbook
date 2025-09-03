import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import '../../../helper/helper.dart';

void main() {
  group(
    '$NavigationTreeTile',
    () {
      final node = WidgetbookUseCase(
        name: 'UseCase Node',
        builder: (context) => Container(),
      );

      testWidgets(
        'when tile is tapped, '
        'then onTap is called',
        (tester) async {
          final voidCallbackMock = VoidFnMock();

          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeTile(
              node: node,
              onTap: voidCallbackMock.call,
            ),
          );

          await tester.findAndTap(find.byType(InkWell));

          verify(voidCallbackMock.call).called(1);
        },
      );

      testWidgets(
        'when node is not leaf, '
        'then $ExpanderIcon is rendered',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeTile(
              node: WidgetbookComponent(
                name: 'Component',
                useCases: [node, node],
              ),
            ),
          );

          expect(
            find.byType(ExpanderIcon),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'when node is leaf, '
        'then $ExpanderIcon is not rendered',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeTile(
              node: node,
            ),
          );

          expect(
            find.byType(ExpanderIcon),
            findsNothing,
          );
        },
      );

      testWidgets(
        'when node is $WidgetbookComponent with single child, '
        'then $ExpanderIcon is not rendered',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            NavigationTreeTile(
              node: WidgetbookComponent(
                name: 'Leaf',
                useCases: [node],
              ),
            ),
          );

          expect(
            find.byType(ExpanderIcon),
            findsNothing,
          );
        },
      );
    },
  );
}
