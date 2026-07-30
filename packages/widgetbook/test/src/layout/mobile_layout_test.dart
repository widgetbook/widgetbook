import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/layout/mobile_layout.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/widgetbook.dart';

import '../navigation/tree_root.dart';

void main() {
  group(
    '$MobileLayout',
    () {
      // The reported freeze in #1989 was iOS-only, so every case runs on
      // all platforms to show whether the behaviour is platform-specific.
      final allPlatforms = TargetPlatformVariant.all();

      Future<void> pumpMobileWidgetbook(WidgetTester tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          Widgetbook.material(
            directories: treeRoot.children!,
          ),
        );
      }

      testWidgets(
        'given the navigation bottom sheet with its search field, '
        'when a use-case is selected, '
        'then the layout settles without rebuilding indefinitely',
        (tester) async {
          await pumpMobileWidgetbook(tester);

          await tester.tap(find.byIcon(Icons.list_outlined));
          await tester.pumpAndSettle();

          expect(find.byType(NavigationPanel), findsOneWidget);
          expect(find.byType(SearchField), findsOneWidget);

          await tester.enterText(find.byType(TextFormField), 'Use');
          await tester.pumpAndSettle();

          await tester.tap(
            find.descendant(
              of: find.byType(NavigationTreeTile),
              matching: find.text('Use-case 2a'),
            ),
          );
          await tester.pumpAndSettle();

          expect(find.byType(NavigationPanel), findsNothing);
        },
        variant: allPlatforms,
      );

      testWidgets(
        'given the navigation bottom sheet was closed, '
        'when it is opened again, '
        'then the search field is restored from the state',
        (tester) async {
          await pumpMobileWidgetbook(tester);

          await tester.tap(find.byIcon(Icons.list_outlined));
          await tester.pumpAndSettle();

          await tester.enterText(find.byType(TextFormField), 'Folder 2');
          await tester.pumpAndSettle();

          // Dismiss the modal by tapping its barrier.
          await tester.tapAt(const Offset(200, 20));
          await tester.pumpAndSettle();

          expect(find.byType(NavigationPanel), findsNothing);

          await tester.tap(find.byIcon(Icons.list_outlined));
          await tester.pumpAndSettle();

          final textField = tester.widget<TextFormField>(
            find.byType(TextFormField),
          );

          expect(textField.controller?.text, 'Folder 2');
        },
        variant: allPlatforms,
      );
    },
  );
}
